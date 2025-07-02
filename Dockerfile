FROM alpine/git AS builder
WORKDIR /app
COPY main.c .
RUN apk add --no-cache gcc musl-dev
RUN gcc -static -Os -o hello main.c && apk add --no-cache upx && upx --best hello

FROM scratch
WORKDIR /app
COPY --from=builder /app/hello .
CMD ["./hello"]