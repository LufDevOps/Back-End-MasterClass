postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

mysql: 
	docker run --name mysql8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres16.3 dropdb --username=postgres simple_bank


migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down


# migrateup:
# 	sql-migrate up

# migratedown:
# 	sql-migrate down

sqlc:
	sqlc generate

test: 
	go test -v -cover ./...
	
server:
	go run main.go

mock:
	mockgen -destination db/mock/store.go example.com/m/v2/db/sqlc Store

proto:
	rm -f pb/*.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative \
    proto/*.proto

evans:
	evans --host localhost --port 9090 -r repl
	# package pb
	# service SimpleBank
	# call CreateUser
	
.PHONY: postgres mysql createdb dropdb migrateup migratedown sqlc server proto mock evans