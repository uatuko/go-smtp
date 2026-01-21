binary = .build/smtp-debug-server

sourcedir = .
sources  := $(shell find $(sourcedir) -type f -name '*.go')

.SILENT: lint

%:
	@:

$(binary): $(sources)
	go build -o $(binary) cmd/smtp-debug-server/main.go

all: $(binary)

clean:
	go clean
	if [ -f $(binary) ] ; then rm $(binary); fi

lint:
	gofmt -s -d -e $(sourcedir)

lint\:ci:
	test -z "$(shell gofmt -s -l $(sourcedir))"

lint\:fix:
	gofmt -s -l -w $(sourcedir)

run:
	go run -race cmd/smtp-debug-server/main.go

test:
	go test -race -tags=test ./...

test\:coverage:
	go test -coverprofile=.coverage.out -covermode=atomic -race -tags=test ./...
