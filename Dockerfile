FROM golang:1.18 as builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

ADD . /forensic
WORKDIR /forensic

RUN go mod tidy
RUN go build

# Package Stage
FROM debian:bookworm-slim
COPY --from=builder /forensic/forensic /