FROM golang:1.22-alpine AS builder

WORKDIR /src

COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -o /app .

FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app /app
COPY templates ./templates

EXPOSE 8080
CMD ["/app"]