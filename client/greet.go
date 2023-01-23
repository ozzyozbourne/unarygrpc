package main

import (
	"context"
	pb "github/ozzyozbourne/gogrpc/protout"
	"log"
)

func doGreet(c pb.GreetServiceClient) {
	log.Println("Do Greet was invoked")
	res, err := c.Greet(context.Background(), &pb.GreetRequest{FirstName: "Osaid Khan"})
	if err != nil {
		log.Fatalf("Could not greet %v\n", err)
	}
	log.Printf("Greeting: %s\n", res.Result)
}
