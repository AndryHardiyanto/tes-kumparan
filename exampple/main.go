package main 

import (
	//"fmt"
	"database/sql"
	"log"
	"net/http"
	"text/template"
	_"github.com/go-sql-driver/mysql"
    "time"
    "encoding/json"
    "io/ioutil"
    "fmt"    
    "gopkg.in/olivere/elastic.v5"
    //"strconv"
    "strings"
    "context"

)

var (
    docType      = "log"
    appName      = "myApp"
    indexName    = "applications"
    err      error
    tmpl = template.Must(template.ParseGlob("form/*"))
)

const (
        mapping   = `
        {
            "aliases":{},
             "mappings":
                {
                    "news":
                    {
                        "properties":
                        {   
                             "ID": 
                              {
                                "type":"long"
                                
                            },
                            "Author":
                             {
                                "type":"text",
                                  "fields":
                                    {
                                    "keyword":
                                        {
                                        "type":"keyword",
                                        "ignore_above":256
                                        }
                                    }
                            },
                            "Body" : {
                                "type":"text",
                                  "fields":
                                    {
                                    "keyword":
                                        {
                                        "type":"keyword",
                                        "ignore_above":256
                                        }
                                    }
                            }
                           
                        }
                    }
                },
                "settings":
                {
                    "index":
                    {
                        "creation_date":"1552148405396",
                        "number_of_shards":5,
                        "number_of_replicas":1,
                        "uuid":"yUzwXW59S4yDZLB7YoW5vA",
                        "version":
                            {
                                "created":"6060199"
                            },
                        "provided_name":"news"
                    }
                }
               
      }
    `
)

type Artikel struct{
	ID int   `json:ID`
	Author string  `json:Author`
	Body string   `json:Body`
    Created time.Time
}

type Finder struct {
    created  time.Time
    id       int
    from, size int
    sort       []string
    pretty     bool
}

type FinderResponse struct {
    Artikels []*Artikel
   CreatedAndID map[int][]NameCount // {1994: [{"Crime":1}, {"Drama":2}], ...}
}

type NameCount struct {
    ID   int
    Created string
}

func (f *Finder) Created(Created time.Time) *Finder {
    f.created = Created
    return f
}

func (f *Finder) ID(ID int) *Finder {
    f.id = ID
    return f
}

func (f *Finder) From(from int) *Finder {
    f.from = from
    return f
}

func NewFinder() *Finder {
    return &Finder{}
}

func (f *Finder) Size(size int) *Finder {
    f.size = size
    return f
}

func (f *Finder) Sort(sort string) *Finder {
    if f.sort == nil {
        f.sort = make([]string, 0)
    }
    f.sort = append(f.sort, sort)
    return f
}

func (f *Finder) Pretty(pretty bool) *Finder {
    f.pretty = pretty
    return f
}

func (f *Finder) paginate(service *elastic.SearchService) *elastic.SearchService {
    if f.from > 0 {
        service = service.From(f.from)
    }
    if f.size > 0 {
        service = service.Size(f.size)
    }
    return service
}

func (f *Finder) sorting(service *elastic.SearchService) *elastic.SearchService {
    if len(f.sort) == 0 {
       
        service = service.Sort("_score", false)
        return service
    }

    for _, s := range f.sort {
        s = strings.TrimSpace(s)

        var field string
        var asc bool

        if strings.HasPrefix(s, "-") {
            field = s[1:]
            asc = false
        } else {
            field = s
            asc = true
        }

        service = service.Sort(field, asc)
    }
    return service
}

func (f *Finder) aggs(service *elastic.SearchService) *elastic.SearchService {

    agg := elastic.NewTermsAggregation().Field("ID")
    service = service.Aggregation("all_ID", agg)

    
    subAgg := elastic.NewTermsAggregation().Field("ID")
    agg = elastic.NewTermsAggregation().Field("Created").
        SubAggregation("ID_by_Created", subAgg)
    service = service.Aggregation("Created_and_ID", agg)

    return service
}
func dbConn()(db *sql.DB){
	dbDriver :="mysql"
	dbUser :="root"
	dbPass :=""
	dbName :="kumparan_db"
	db, err:= sql.Open(dbDriver,dbUser+":"+dbPass+"@/"+dbName)

	if err != nil{
		panic(err.Error())
	}
	return db
}

func connectToElasticsearch()(elasticClient *elastic.Client) {
    elasticClient, err = elastic.NewClient(elastic.SetURL("http://localhost:9200"))
    if err != nil {
        fmt.Println(err)
    }
    return elasticClient
}

func (f *Finder) Find(ctx context.Context, client *elastic.Client) (FinderResponse,error) {
    var resp FinderResponse

    search := client.Search().Index(indexName).Type("_doc").Pretty(f.pretty)
    search = f.aggs(search)
    search = f.sorting(search)
    search = f.paginate(search)

    sr, err := search.Do(ctx)
    if err != nil {
        return resp, err
    }

    artikels, err := f.decodeArtikel(sr)
    if err != nil {
        return  resp,err
    }

    resp.Artikels = artikels

    if agg, found := sr.Aggregations.Terms("Created_and_ID"); found {
        resp.CreatedAndID = make(map[int][]NameCount)
        for _, bucket := range agg.Buckets {
            floatValue, ok := bucket.Key.(float64)
            if !ok {
                panic("expected a float64")
            }
            var (
                id          = int(floatValue)
                created []NameCount
            )
            if subAgg, found := bucket.Terms("ID_by_Created"); found {
                for _, subBucket := range subAgg.Buckets {
                    created  = append(created , NameCount{
                        ID:  subBucket.Key.(int),
                        Created: subBucket.Key.(string),
                    })
                }
            }
            resp.CreatedAndID[id] = created
        }
    }

    return resp,nil
}

func (f *Finder) decodeArtikel(res *elastic.SearchResult) ([]*Artikel, error) {
    if res == nil || res.TotalHits() == 0 {
        return nil, nil
    }

    var artikels []*Artikel
    for _, hit := range res.Hits.Hits {
        artikel := new(Artikel)
        if err := json.Unmarshal(*hit.Source, artikel); err != nil {
            return nil, err
        }
        // TODO Add Score here, e.g.:
        // film.Score = *hit.Score
        artikels = append(artikels, artikel)
    }
    return artikels, nil
}


func Index(w http.ResponseWriter, r *http.Request) {

    db := dbConn()
 
   //elasticClient :=connectToElasticsearch()

    selDB, err := db.Query("SELECT id,Author,body FROM msartikel where status <>'D'")
    if err != nil {
        panic(err.Error())
    }
    emp := Artikel{}
    res := []Artikel{}
  
    for selDB.Next() {
       
        var id int
        var Author, Body string

        err = selDB.Scan(&id, &Author, &Body)
        if err != nil {
            panic(err.Error())
        }
        emp.ID = id
        emp.Author = Author
        emp.Body = Body
       
        res = append(res, emp)
 
    }   
       rankingsJson, _ :=json.Marshal(res)

    //createIndex(string(rankingsJson),elasticClient)
    w.Header().Set("Content-Type", "application/json")
    
    json.NewEncoder(w).Encode(res)
  // getElastic()
    jsonWriter := ioutil.WriteFile("Get.json",rankingsJson ,0777)
       if jsonWriter != nil {
        fmt.Println(jsonWriter)
   }
   // tmpl.ExecuteTemplate(w, "Index",res)
    defer db.Close()
}

func postNews(w http.ResponseWriter, r *http.Request){
    db := dbConn()
    elasticClient :=connectToElasticsearch()
        
    if r.Method == "POST" {
        id:= getMaxID()
        res := []Artikel{}
        err :=  json.NewDecoder(r.Body).Decode(&res);
        if err != nil {
            panic(err.Error())
        }
        for i:=0;i<len(res);i++{
            insForm, err := db.Prepare("INSERT INTO msartikel(id,status,userin,datein,Author,body,created) VALUES(?,?,?,?,?,?,?)")
            if err != nil {
                panic(err.Error())
            }
            id=id+1
            res[i].ID=id
            insForm.Exec(id, "A","Admin",time.Now(),res[i].Author,res[i].Body,time.Now())
            //coba1.append(coba1,coba)
            
        }
       err = createNewsElastic(elasticClient,res)
       if err != nil {
          fmt.Println(err)
          log.Println(err)
        }
       rankingsJson, _ :=json.Marshal(res)

    
       jsonWriter := ioutil.WriteFile("Post.json",rankingsJson ,0777)
       if jsonWriter != nil {
          fmt.Println(jsonWriter)
        }
       
    }else{
        log.Println("Method not Post");
    }
    defer db.Close()
    //http.Redirect(w, r, "/", 301)
}

func getMaxID() int{
    db := dbConn()   
    
    selDB, err := db.Query("SELECT max(id) FROM msartikel")
    if err != nil {
        panic(err.Error())
    }
    
    
    var id int
    selDB.Next() 
    err = selDB.Scan(&id)
    if err != nil {
        panic(err.Error())
    }
    return id  
}

func New(w http.ResponseWriter, r *http.Request) {
    tmpl.ExecuteTemplate(w, "New", nil)
}

func Edit(w http.ResponseWriter, r *http.Request) {
    db := dbConn()
    nId := r.URL.Query().Get("id")
    selDB, err := db.Query("SELECT id,Author,body FROM msartikel WHERE id=? and status <>'D' ", nId)
    if err != nil {
        panic(err.Error())
    }
    emp := Artikel{}
    for selDB.Next() {
        var id int
        var Author, body string
        err = selDB.Scan(&id, &Author, &body)
        if err != nil {
            panic(err.Error())
        }
        emp.ID = id
        emp.Author = Author
        emp.Body = body
    }
    tmpl.ExecuteTemplate(w, "Edit", emp)
    defer db.Close()
}

func Update(w http.ResponseWriter, r *http.Request) {
    db := dbConn()
    if r.Method == "POST" {
        Author := r.FormValue("Author")
        body := r.FormValue("body")
        id := r.FormValue("uid")
        insForm, err := db.Prepare("UPDATE msartikel SET Author=?, body=? WHERE id=? and status <>'D' ")
        if err != nil {
            panic(err.Error())
        }
        insForm.Exec(Author, body, id)
    }
    defer db.Close()
    http.Redirect(w, r, "/", 301)
}

func Delete(w http.ResponseWriter, r *http.Request) {
    db := dbConn()
    emp := r.URL.Query().Get("id")
    delForm, err := db.Prepare("DELETE FROM msartikel WHERE id=? ans status <>'D' ")
    if err != nil {
        panic(err.Error())
    }
    delForm.Exec(emp)
    
    defer db.Close()
    http.Redirect(w, r, "/", 301)
}

func deleteData(w http.ResponseWriter, r *http.Request){
    db := dbConn() 
    emp := r.URL.Query().Get("id")
    log.Println(emp)
    delForm, err := db.Prepare("update msartikel set status = 'D' WHERE id=? and status <>'D' ")
    if err != nil {
        panic(err.Error())
    }
    delForm.Exec(emp)
    
    defer db.Close()
    http.Redirect(w, r, "/", 301)   
}

func createNewsElastic(client *elastic.Client,json []Artikel) error {
    ctx := context.Background()
    exists, err := client.IndexExists("news").Do(ctx)
    if err != nil {
        return err
    }
    if exists {
        _, err = client.DeleteIndex("news").Do(ctx)
        if err != nil {
            return err
        }
    }
   
   
   //Create index with mapping
    // _, err = client.CreateIndex("news").Body(mapping).Do(ctx)
    // if err != nil {
    //     return err
    // }
   
    // Artikels := []Artikel{
    //     {ID:1,Author: "The Shawshank Redemption", Body: "Frank Darabont"},
    //     {ID:1,Author: "The Godfather",  Body: "Francis Ford Coppola"},
    //     {ID:1,Author: "The Godfather: Part II", Body: "Francis Ford Coppola"},
    //     {ID:1,Author: "The Dark Knight",Body: "Christopher Nolan"},
    //     {ID:1,Author: "12 Angry Men", Body: "Sidney Lumet"},
    //     {ID:1,Author: "Schindler's List", Body: "Steven Spielberg"},
    //     {ID:1,Author: "The Lord of the Rings: The Return of the King",Body: "Peter Jackson"},
    //     {ID:1,Author: "Pulp Fiction", Body: "Quentin Tarantino"},
    //     {ID:1,Author: "Il buono, il brutto, il cattivo", Body: "Sergio Leone"},
    //     {ID:1,Author: "Fight Club", Body: "David Fincher"},
    // }
    log.Println(json)
    for _, artikel := range json {
        
        _, err = client.Index().
            Index("news").
             Type("news").
            BodyJson(artikel).
            Do(ctx)
        if err != nil {
            return err
        }
    }
    _, err = client.Flush("news").WaitIfOngoing(true).Do(ctx)
    return err
}

func getElastic(){
    f := NewFinder()
    elasticClient :=connectToElasticsearch()

    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    res, err := f.Find(ctx, elasticClient)
    if err != nil {
        panic(err)
    }

    for i, artikel := range res.Artikels {
        prefix := "├"
        if i == len(res.Artikels)-1 {
            prefix = "└"
        }
        fmt.Printf("%d %s %s %s from %d\n", prefix, artikel.ID, artikel.Created,artikel.Body,artikel.Author)
    }
    
}
func main() {

 
    log.Println("Server started on: http://localhost:6060")
     http.HandleFunc("/", Index)
  
    http.HandleFunc("/news", New)
    http.HandleFunc("/edit", Edit)
     http.HandleFunc("/insert", postNews)
    http.HandleFunc("/update", Update)
    http.HandleFunc("/delete", deleteData)
     http.ListenAndServe(":6060", nil)
}
