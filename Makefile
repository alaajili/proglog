CONFIG_PATH=${HOME}/.config/proglog/certs

.PHONY: init
init:
	@mkdir -p ${CONFIG_PATH}
	@echo "config path: ${CONFIG_PATH}"

.PHONY: gencert
gencert: init
	@cfssl gencert -initca certs/ca-csr.json | cfssljson -bare ca
	@cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=${PWD}/certs/ca-config.json \
		-profile=server \
		certs/server-csr.json | cfssljson -bare server
	@mv *.pem *.csr ${CONFIG_PATH}
	@echo "certs generated at ${CONFIG_PATH}"

.PHONY: test
test:
	@go test -race ./...
	@echo "all tests passed"

.PHONY: compile
compile:
	protoc api/v1/*.proto \
			--go_out=. \
			--go-grpc_out=. \
			--go_opt=paths=source_relative \
			--go-grpc_opt=paths=source_relative \
			--proto_path=.
	@echo "protos compiled successfully"
