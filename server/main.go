package main

import (
	pb "github/ozzyozbourne/gogrpc/protout"
	"google.golang.org/grpc"
	"log"
	"net"
)

const ADDRESS string = "0.0.0.0:8080"

type Server struct {
	pb.GreetServiceServer
}

func main() {

	lis, err := net.Listen("tcp", ADDRESS)

	if err != nil {
		log.Fatalf("Failed to listen on : %v\n", err)
		return
	}
	log.Printf("Listening on %s\n", ADDRESS)

	server := grpc.NewServer()

	if err = server.Serve(lis); err != nil {
		log.Fatalf("Failed to server: %v\n", err)
	}

}
