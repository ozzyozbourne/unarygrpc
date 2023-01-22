package main

import (
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"log"
)

const ADDRESS string = "0.0.0.0:8080"

func main() {
	con, err := grpc.Dial(ADDRESS, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("Failed to connect %v\n", err)
	}
	defer func(con *grpc.ClientConn) {
		err := con.Close()
		if err != nil {
			log.Fatalf("Failed to close the connection properly %v\n", err)
		} else {
			log.Println("Connection terminated successfully")
		}
	}(con)
	log.Println("CONNECTED")
}
