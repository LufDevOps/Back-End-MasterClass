package gapi

import (
	"fmt"

	db "example.com/m/v2/db/sqlc"
	"example.com/m/v2/pb"
	"example.com/m/v2/token"
	"example.com/m/v2/util"
)

// Server serves gRPC requests for our banking service.
type Server struct {
	pb.UnimplementedSimpleBankServer
	config util.Config
	store db.Store
	tokenMaker token.Maker
}

// NewServer creates a new gRPC server.
func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewJWTMaker(config.TokenSymmetricKey)
	// fmt.Println("tokenmaker: ",tokenMaker)
	if err != nil {
		return nil,
		fmt.Errorf("cannot create token maker: %w", err)
	}
	server := &Server{
		config : config,
		store :	store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}

