all: bin/galasabld-linux-amd64 bin/galasabld-windows-amd64 bin/galasabld-darwin-amd64 bin/galasabld-linux-s390x



bin/galasabld-linux-amd64 : ./cmd/galasabld/main.go ./pkg/cmd/root.go ./pkg/cmd/template.go ./pkg/galasayaml/release.go
	GOOS=linux GOARCH=amd64 go build -o bin/galasabld-linux-amd64 ./cmd/galasabld

bin/galasabld-windows-amd64 : ./cmd/galasabld/main.go ./pkg/cmd/root.go ./pkg/cmd/template.go ./pkg/galasayaml/release.go
	GOOS=windows GOARCH=amd64 go build -o bin/galasabld-windows-amd64 ./cmd/galasabld

bin/galasabld-darwin-amd64 : ./cmd/galasabld/main.go ./pkg/cmd/root.go ./pkg/cmd/template.go ./pkg/galasayaml/release.go
	GOOS=darwin GOARCH=amd64 go build -o bin/galasabld-darwin-amd64 ./cmd/galasabld

bin/galasabld-linux-s390x : ./cmd/galasabld/main.go ./pkg/cmd/root.go ./pkg/cmd/template.go ./pkg/galasayaml/release.go
	GOOS=linux GOARCH=s390x go build -o bin/galasabld-linux-s390x ./cmd/galasabld


clean:
	rm -rf bin
