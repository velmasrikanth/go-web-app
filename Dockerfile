FROM golang:1.23-rc-alpine3.20 AS builder

WORKDIR /app

COPY ./go.mod .
# coping a file to download dependecies

RUN go mod download
# to download the depencies

copy . .
# copying code data

RUN go build -o main .
# building the application it will generate application file "main"

# running the app by using distroless images
FROM gcr.io/distroless/base-debian10

COPY --from=builder /app/main .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD [ "./main" ]

