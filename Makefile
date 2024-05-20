postgres:
	docker run --name postgres16.3 -p 5433:5432 -e POSTGRES_PASSWORD=secret -d postgres:16.3

mysql: 
	docker run --name mysql8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

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

mock:
	mockgen -destination db/mock/store.go example.com/m/v2/db/sqlc Store

.PHONY: postgres mysql createdb dropdb migrateup migratedown sqlc server