compile:
	@protoc api/v1/*.proto \
		--go_out=. \
		--go_opt=paths=source_relative \
		--proto_path=.
	@echo "Compiled .proto files"

test:
	@go test -race ./...
	@echo "Tests passed"

.PHONY: compile test
