# Super simple dockerfile, feel free to modify

FROM golang:alpine AS builder

WORKDIR /go/src/app
COPY /app/thalestest.go .
RUN go build -o thalestest .

FROM alpine
WORKDIR /app
COPY --from=builder /go/src/app /app/
EXPOSE 8080

# RUN go run thalestest.go
CMD ["./thalestest"]
