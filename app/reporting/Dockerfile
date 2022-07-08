FROM golang:1.15-buster AS build

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /reporting

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /
COPY --from=build /reporting /reporting
EXPOSE 8888
USER nonroot:nonroot

ENTRYPOINT ["/reporting"]
