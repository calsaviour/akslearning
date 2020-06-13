# Super simple dockerfile, feel free to modify

FROM golang:latest

RUN mkdir -p /app

WORKDIR /app

COPY /app/thalestest.go /app

EXPOSE 8080

# RUN go run thalestest.go
CMD go run thalestest.go