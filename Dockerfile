FROM scratch
MAINTAINER Sofiane Imadali <sofiane.imadali@orange.com>

WORKDIR /app

COPY ./testJSONValidation /app

ENTRYPOINT ["/app/testJSONValidation"]
