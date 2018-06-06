FROM byrnedo/alpine-curl:latest as builder
ARG VERSION=2.1.4

WORKDIR /app
ADD https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-$VERSION/browsermob-proxy-$VERSION-bin.zip /app/
RUN unzip browsermob-proxy-$VERSION-bin.zip && \
    rm browsermob-proxy-$VERSION-bin.zip && \
    mv /app/browsermob-proxy-$VERSION /app/browsermob-proxy

FROM java:8-jre-alpine
WORKDIR /app
COPY --from=builder /app/browsermob-proxy /app/browsermob-proxy
EXPOSE 8080
EXPOSE 39500-39999
ENTRYPOINT ["/app/browsermob-proxy/bin/browsermob-proxy"]
