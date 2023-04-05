# ELT Automation with Airflow

The project uses the simple ELT approach to create a star schema data warehouse in Amazon Redshift. The data is extracted from the [sample DVD rental](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/) database in 3rd Normal Form in Postgres RDS, and then loaded into temporary tables in Redshift. The data is transformed and loaded into the final star schema tables in a single step. Airflow is used to automate the ELT process.

![DVD Rental Sample Database Diagram](/img/dvd-rental-sample-database-diagram.png)
![DVD Rental Star Schema Diagram](/img/dvdrental_star_schema.drawio.png)
