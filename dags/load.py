import boto3
import configparser
import psycopg2
from tables import tables

parser = configparser.ConfigParser()
parser.read("pipeline.conf")
dbname = parser.get("aws_creds", "database")
user = parser.get("aws_creds", "username")
password = parser.get("aws_creds", "password")
host = parser.get("aws_creds", "host")
port = parser.get("aws_creds", "port")


# connect to the redshift cluster
rs_conn = psycopg2.connect(
    "dbname=" + dbname
    + " user=" + user
    + " password=" + password
    + " host=" + host
    + " port=" + port)

parser = configparser.ConfigParser()
parser.read("pipeline.conf")
account_id = parser.get("aws_boto_credentials",
                        "account_id")
iam_role = parser.get("aws_creds", "iam_role")
bucket_name = parser.get("aws_boto_credentials",
                         "bucket_name")


def load(table):
    # Truncate the table before loading the data
    cur = rs_conn.cursor()
    cur.execute("TRUNCATE TABLE public.{};".format(table))
    cur.close()

    # run the COPY command to load the file into Redshift
    file_path = ("s3://"
                 + bucket_name
                 + "/{}_extract.csv".format(table))
    role_string = ("arn:aws:iam::"
                   + account_id
                   + ":role/" + iam_role)

    sql = "COPY public." + table
    sql = sql + " from %s "
    sql = sql + " iam_role %s;"

    # create a cursor object and execute the COPY command
    cur = rs_conn.cursor()
    cur.execute(sql, (file_path, role_string))
    print("Loaded {} into Redshift".format(table))

    # close the cursor and commit the transaction
    cur.close()
    rs_conn.commit()


for table in tables:
    load(table)

# close the connection
rs_conn.close()
