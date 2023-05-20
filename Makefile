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



clean_client:
	rm buildout/client_linux
	rm buildout/client_windows



build_server_linux:
	GOOS=linux GOARCH=amd64 go build -o buildout/server_linux ./server


build_server_windows:
	GOOS=windows GOARCH=amd64 go build -o buildout/server_windows ./server



build_client_linux:
	GOOS=linux GOARCH=amd64 go build -o buildout/client_linux ./client



build_client_windows:
	GOOS=windows GOARCH=amd64 go build -o buildout/client_windows ./client


all:  clean_proto  clean_server generate build_server_linux build_server_windows build_client_linux build_client_windows

