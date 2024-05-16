postgres:
	docker run --name postgres16.3 -p 5433:5432 -e POSTGRES_PASSWORD=secret -d postgres:16.3

createdb:
	docker exec -it postgres16.3 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres16.3 dropdb --username=postgres simple_bank

migrateup:
	sql-migrate up

migratedown:
	sql-migrate down

sqlc:
	sqlc generate

test: 
	go test -v -cover ./...
	
server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown sqlc server