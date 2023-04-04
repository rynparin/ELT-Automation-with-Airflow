import psycopg2
import csv
import boto3
import configparser
import os
from tables import tables

parser = configparser.ConfigParser()
parser.read("pipeline.conf")
dbname = parser.get("postgres_config", "database")
user = parser.get("postgres_config", "username")
password = parser.get("postgres_config",
                      "password")
host = parser.get("postgres_config", "host")
port = parser.get("postgres_config", "port")

conn = psycopg2.connect(
    "dbname=" + dbname
    + " user=" + user
    + " password=" + password
    + " host=" + host,
    port=port)


def extract(table):
    m_query = "SELECT * FROM {};".format(table)
    local_filename = "{}_extract.csv".format(table)

    m_cursor = conn.cursor()
    m_cursor.execute(m_query)
    results = m_cursor.fetchall()

    try:
        with open(local_filename, 'w') as fp:
            csv_w = csv.writer(fp, delimiter='|')
            csv_w.writerows(results)
    except Exception as e:
        print(f"Error while writing to file: {e}")
        return

    m_cursor.close()

    # load the aws_boto_credentials values
    parser = configparser.ConfigParser()
    parser.read("pipeline.conf")
    access_key = parser.get(
        "aws_boto_credentials",
        "access_key")
    secret_key = parser.get(
        "aws_boto_credentials",
        "secret_key")
    bucket_name = parser.get(
        "aws_boto_credentials",
        "bucket_name")

    s3 = boto3.client(
        's3',
        aws_access_key_id=access_key, aws_secret_access_key=secret_key)

    try:
        s3.upload_file(
            local_filename,
            bucket_name,
            local_filename)
        print("File uploaded to S3")
    except Exception as e:
        print(f"Error while uploading file to S3: {e}")
        return

    os.remove(local_filename)


for table in tables:
    extract(table)

conn.close()
