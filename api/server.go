package api

import (
	db "example.com/m/v2/db/sqlc"
	"github.com/gin-gonic/gin"
)

// Server serves HTTP requests for our banking service.
type Server struct {
	store *db.Store
	route *gin.Engine
}

// NewServer creates a new HTTP server and setup routing.
func NewServer(store *db.Store) *Server {
	server := &Server{store :store}
	router := gin.Default()

	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccount)

	server.route = router
	return server
}

func(server *Server) Start(address string) error {
	return server.route.Run(address)
}

func errorResponse(err error) gin.H{
	return gin.H{"error": err.Error()}
}