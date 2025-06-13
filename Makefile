BINARY_NAME=hello
GO=go
TEMPL=go run github.com/a-h/templ/cmd/templ@latest generate
GOSEC=go run github.com/securego/gosec/v2/cmd/gosec@latest -exclude-dir=.codesphere-internal

.PHONY: all build run clean test tidy generate lint release help

all: build

build:
	@echo "Compiling project..."
	$(GO) build -o $(BINARY_NAME)

run:
	@echo "Starting app..."
	$(GO) run .

test:
	@echo "Running tests..."
	$(GO) test -v ./...

lint:
	@echo "Running security scanner..."
	$(GOSEC) ./...

tidy:
	@echo "Tidying go.mod and go.sum files..."
	$(GO) mod tidy

generate:
	@echo "Generating templ files..."
	$(TEMPL)

release:
ifeq ($(strip $(VERSION)),)
	$(error Usage: make release VERSION=vX.Y.Z)
endif
	@echo "Creating and pushing tag $(VERSION)..."
	git tag -a $(VERSION) -m "Release $(VERSION)"
	git push origin $(VERSION)

clean:
	@echo "Removing compiled app..."
	$(GO) clean
	rm -f $(BINARY_NAME)

.DEFAULT_GOAL := help
help:
	@echo "Available commands:"
	@echo "  make build      - Compile the project"
	@echo "  make run        - Start the application"
	@echo "  make test       - Run all tests"
	@echo "  make lint       - Run security scanner (gosec)"
	@echo "  make tidy       - Tidy go.mod and go.sum files"
	@echo "  make generate   - Generate code from .templ files"
	@echo "  make release    - Create and push a new release tag (e.g., make release VERSION=v1.0.0)"
	@echo "  make clean      - Remove the compiled application"
	@echo "  make help       - Show this help message"