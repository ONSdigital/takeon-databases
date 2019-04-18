# Get postgres Server parent image
# FROM postgres:11-alpine
FROM postgres:11-alpine

# set working directory
WORKDIR /postgres

# Accept EULA
ENV POSTGRES_PASSWORD=docker
ENV HOSTNAME=localhost
# Set DB environment
#ENV SA_PASSWORD=aVerySecurePassword!123
ENV DB_NAME=CollectionDev

# ENV PGDATA=/var/lib/postgresql/data

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update \
    && apk add -u postgis \
    && rm -rf /var/lib/apt/lists/*

RUN apk add --no-cache --virtual .build-deps gcc musl-dev && \
    apk add g++ && \
    apk add python3-dev

RUN apk add freetds-dev && \
	apk add py3-pip && \
	apk add unixodbc-dev && \
	apk add openrc
# RUN /etc/init.d/postgresql start

# copy
COPY . /postgres
#RUN openrc
#RUN touch /run/openrc/softlevel

EXPOSE 5432
RUN adduser -D postgres_user
COPY tables.sql /docker-entrypoint-initdb.d/
# RUN mv /etc/init.d/postgresql /postgres
# RUN rm -rf /etc/init.d/postgresql 
# Run entrypoint
RUN pip3 install psycopg2
RUN python3 generateContributors.py
# CMD  exec /bin/ash Entry.sh
