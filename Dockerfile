FROM --platform=$BUILDPLATFORM alpine:latest AS builder
WORKDIR /root
RUN apk add --no-cache git make build-base && \
    git clone --branch master --single-branch https://github.com/GegeDesembri/vlmcsd.git && \
    cd vlmcsd/ && \
    make

FROM alpine:latest
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
EXPOSE 1688
CMD [ "/usr/bin/vlmcsd", "-D", "-e" ]
