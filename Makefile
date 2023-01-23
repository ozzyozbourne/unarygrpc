PROTO_DIR = protofiles
PROTO_OUT = protout
PACKAGE = $(shell head -1 go.mod | awk '{print $$2}')

generate:
	protoc -I${PROTO_DIR} --go_opt=module=${PACKAGE} --go_out=. --go-grpc_opt=module=${PACKAGE} --go-grpc_out=. ${PROTO_DIR}/*.proto


clean_proto:
	rm ${PROTO_OUT}/*.pb.go


clean_server:
	rm buildout/server

clean_client:
	rm buildout/client


build_server:
	go build -o buildout/server ./server

build_client:
	go build -o buildout/client ./client


all:  clean_proto clean_client clean_server generate build_client build_server

