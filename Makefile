PROTO_DIR = protofiles
PROTO_OUT = protout
PACKAGE = $(shell head -1 go.mod | awk '{print $$2}')

generate:
	protoc -I${PROTO_DIR} --go_opt=module=${PACKAGE} --go_out=. --go-grpc_opt=module=${PACKAGE} --go-grpc_out=. ${PROTO_DIR}/*.proto


clean_proto:
	rm ${PROTO_OUT}/*.pb.go


clean_output:
	rm buildout/*


build:
	go build -o buildout/client ./client/main.go
	go build -o buildout/server ./server/main.go


run:
	./gogrpc


all: clean_output clean_proto generate build run

