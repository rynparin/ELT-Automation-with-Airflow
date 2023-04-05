# ELT Automation with Airflow
The project uses the ELT approach to create a star schema data warehouse in Amazon Redshift. The data is extracted from the sample DVD rental database in 3rd Normal Form in Postgres RDS, and then loaded into temporary tables in Redshift. The data is transformed and loaded into the final star schema tables in a single step. Airflow is used to automate the ELT process.
