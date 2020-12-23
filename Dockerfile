FROM golang:1.13 as builder

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/github.com/kedacore/sample-go-rabbitmq

COPY . .

RUN export GOPROXY="https://goproxy.cn" && go mod download 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install ./...

FROM scratch
COPY --from=builder /go/bin/receive /go/bin/send /usr/local/bin/
CMD ["receive"]
