FROM golang:1.19-alpine as builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

RUN apk --no-cache add sqlite

EXPOSE 8080

CMD ["./main"]
