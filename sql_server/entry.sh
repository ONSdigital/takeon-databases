#!/bin/bash
   # start SQL Server
   sh -c " 
   echo 'Sleeping 20 seconds before running setup script'
   sleep 20s

   echo 'Starting setup script'
   echo ${DATASOURCE_USERNAME}
   echo ${DATASOURCE_PASSWORD}

   # run the setup script to create the DB and the schema in the DB
   echo 'Creating DB'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -Q 'CREATE DATABASE CollectionDev'
   echo 'Creating tables'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i contributor.sql
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i validation.sql
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i form.sql
   echo 'Inserting into form tables'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i insert_into_forms.sql
   echo 'Inserting into rule table'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i validation_rule_insert.sql
   echo 'Inserting into validationForm table'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i validation_form_insert.sql
   pip3 install -r requirements.txt
   echo 'Generating contributors'
   python3 generateContributors.py

   echo 'Creating responses'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i generateResponses.sql
   echo 'Removing trailing spaces'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i cleanUpResponses.sql
   echo 'Creating validation data'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATASOURCE_USERNAME} -P ${DATASOURCE_PASSWORD} -i generateValidationDateFromPreExistingData.sql


   echo 'Finished setup script'
   exit
   " & 
   exec /opt/mssql/bin/sqlservr
