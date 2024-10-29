
# Первый этап - сборка приложения
FROM golang:1.20-alpine as builder

# Устанавливаем рабочую директорию
WORKDIR /build

# Копируем исходный код в контейнер
COPY . .

# Сборка приложения с отключением CGO
RUN go mod init hello && go mod tidy && go mod download && go build -o /hello main.go

FROM alpine:3

COPY --from=builder hello /bin/hello

# Открываем порт 8080
EXPOSE 8080

# Запуск приложения
CMD [/bin/hello]

main.go:

package main

import (
    fmt
    log
    net/http
)

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, Hello, World!)
}

func main() {
    http.HandleFunc(/, helloWorldHandler)

    port := :8080
    fmt.Printf(Сервер запущен на порту %sn, port)
    if err := http.ListenAndServe(port, nil); err != nil {
        log.Fatalf(Ошибка запуска сервера: %s, err)
    }
}

