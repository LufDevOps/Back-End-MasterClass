FROM golang:1.21-alpine
COPY ./build/migration/migrate.sh ./
RUN apk add --no-cache postgresql-client jq && \
apk add --no-cache git && \
CGO_ENABLED=0 go install github.com/rubenv/sql-migrate/...@latest && \
chmod +x migrate.sh
COPY ./build/migration/dbconfig.yml ./
COPY ./migrations ./migrations
ENTRYPOINT ["./migrate.sh"]
