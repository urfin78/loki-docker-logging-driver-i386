FROM i386/golang:1.12.7-buster as gobuild
RUN apt-get update && apt-get -y install libsystemd-dev
ENV GOPATH=/go/src/app
WORKDIR /go/src/app
RUN go get github.com/grafana/loki; exit 0
WORKDIR /go/src/app/src/github.com/grafana/loki
RUN go build ./cmd/docker-driver
FROM i386/debian:stretch-slim
COPY --from=gobuild /go/src/app/src/github.com/grafana/loki/docker-driver /bin/docker-driver
COPY --from=gobuild /go/src/app/src/github.com/grafana/loki/cmd/docker-driver/pipeline-example.yaml /etc/loki/pipeline-example.yaml
WORKDIR /bin/
ENTRYPOINT [ "/bin/docker-driver" ]
