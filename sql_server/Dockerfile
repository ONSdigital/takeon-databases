# Get SQL Server parent image
FROM mcr.microsoft.com/mssql/server:2017-latest

# set working directory
WORKDIR /sql_scripts

# Accept EULA
ENV ACCEPT_EULA=Y
ENV MSSQL_MSSQL_TCP_PORT=1234

# Set DB environment
ENV SA_PASSWORD=aVerySecurePassword!123
ENV DB_NAME=CollectionDev

# Get updates and install
RUN apt update -y && apt install freetds-dev -y apt && \ 
	apt install python3-pip -y && \ 
	apt install unixodbc-dev -y

# copy
COPY . /sql_scripts

EXPOSE 1433

# Run entrypoint
CMD  exec /bin/bash entry.sh
