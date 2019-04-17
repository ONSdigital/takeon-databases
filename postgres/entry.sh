#!/bin/ash
   # start SQL Server
   sh -c " 
   echo 'Sleeping 20 seconds before running setup script'
   sleep 20s

   echo 'Starting setup script'

   # run the setup script to create the DB and the schema in the DB
   echo 'Creating DB'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -Q 'CREATE DATABASE CollectionDev'
   echo 'Creating tables'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i contributor.sql
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i validation.sql
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i form.sql
   echo 'Inserting into form tables' 
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i insert_into_forms.sql
   echo 'Inserting into rule table'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i validation_rule_insert.sql
   echo 'Inserting into validationForm table'   
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i validation_form_insert.sql
   pip3 install -r requirements.txt
   echo 'Generating contributors'
   python3 generateContributors.py

   echo 'Creating responses'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i generateResponses.sql
   echo 'Removing trailing spaces'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i cleanUpResponses.sql
   echo 'Creating validation data'
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'aVerySecurePassword!123' -i generateValidationDateFromPreExistingData.sql



   echo 'Finished setup script'
   exit
   " & 
   exec /usr/bin/postgres

