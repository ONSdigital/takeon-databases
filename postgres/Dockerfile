# Get postgres Server parent image
FROM postgres:11-alpine

# set working directory
WORKDIR /postgres

# Accept EULA
ENV POSTGRES_PASSWORD=docker

# Set DB environment
#ENV SA_PASSWORD=aVerySecurePassword!123
ENV DB_NAME=CollectionDev

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update \
    && apk add -u postgis \
    && rm -rf /var/lib/apt/lists/*

RUN apk add --no-cache --virtual .build-deps gcc musl-dev

RUN apk add freetds-dev && \
	apk add py3-pip && \
	apk add unixodbc-dev 


# copy
COPY . /postgres

EXPOSE 5432

# Run entrypoint
#CMD  exec /bin/bash entry.sh
