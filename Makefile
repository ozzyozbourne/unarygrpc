PROTO_DIR = protofiles
PROTO_OUT = protout
PACKAGE = $(shell head -1 go.mod | awk '{print $$2}')

generate:
	protoc -I${PROTO_DIR} --go_opt=module=${PACKAGE} --go_out=. --go-grpc_opt=module=${PACKAGE} --go-grpc_out=. ${PROTO_DIR}/*.proto


clean_proto:
	rm ${PROTO_OUT}/*.pb.go


clean_server:
	rm buildout/server_linux
	rm buildout/server_windows
	rm buildout/server_mac


clean_client:
	rm buildout/client_linux
	rm buildout/client_windows
	rm buildout/client_mac


build_server:
	GOOS=linux GOARCH=amd64 go build -o buildout/server_linux ./server
	GOOS=darwin GOARCH=amd64 go build -o buildout/server_mac ./server
	GOOS=windows GOARCH=amd64 go build -o buildout/server_windows.exe ./server



build_client:
	GOOS=linux GOARCH=amd64 go build -o buildout/client_linux ./client
	GOOS=darwin GOARCH=amd64 go build -o buildout/client_mac ./client
	GOOS=windows GOARCH=amd64 go build -o buildout/client_windows.exe ./client


all:  clean_proto clean_server clean_client generate build_server build_client

