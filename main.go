package main

import (
	"database/sql"
	"log"

	"example.com/m/v2/api"
	db "example.com/m/v2/db/sqlc"
	"example.com/m/v2/util"
	_ "github.com/lib/pq"
)

func main(){
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("caannot load config:", err)
	}
	conn, err := sql.Open(config.DB_DRIVER, config.DB_SOURCE)
	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err !=nil {
		log.Fatal("cannot create server:", err)
	}
	err = server.Start(config.SERVER_ADDRESS)

	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}