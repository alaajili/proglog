CONFIG_PATH=${HOME}/.config/proglog/certs

.PHONY: init
init:
	@mkdir -p ${CONFIG_PATH}
	@echo "config path: ${CONFIG_PATH}"

.PHONY: gencert
gencert: copycert
	@cfssl gencert -initca certs/ca-csr.json | cfssljson -bare ca

	@cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=certs/ca-config.json \
		-profile=server \
		certs/server-csr.json | cfssljson -bare server
	@echo "generated server certs"

	@cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=certs/ca-config.json \
		-profile=client \
		-cn="root" \
		certs/client-csr.json | cfssljson -bare root-client
	@cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=certs/ca-config.json \
		-profile=client \
		-cn="nobody" \
		certs/client-csr.json | cfssljson -bare nobody-client
	@echo "generated clients certs"

	@mv *.pem *.csr ${CONFIG_PATH}
	@echo "certs generated at ${CONFIG_PATH}"

.PHONY: rmcert
rmcert:
	@rm -rf ${CONFIG_PATH}/*.pem ${CONFIG_PATH}/*.csr
	@echo "certs removed from ${CONFIG_PATH}"

$(CONFIG_PATH)/model.conf:
	@cp certs/model.conf $(CONFIG_PATH)/model.conf

$(CONFIG_PATH)/policy.csv:
	@cp certs/policy.csv $(CONFIG_PATH)/policy.csv

.PHONY: copycert
copycert: init $(CONFIG_PATH)/model.conf $(CONFIG_PATH)/policy.csv
	@echo "copied model.conf and policy.csv to ${CONFIG_PATH}"

.PHONY: test
test: $(CONFIG_PATH)/policy.csv $(CONFIG_PATH)/model.conf
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
