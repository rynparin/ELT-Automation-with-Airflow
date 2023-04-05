from datetime import datetime
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator

default_args = {
    'owner': 'ryn',
    'depends_on_past': False,
    'start_date': datetime(2023, 4, 5),
}

with DAG(
    'elt',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
) as dag:

    extract = BashOperator(
        task_id='extract',
        bash_command='python dags/extract.py',
    )

    load = BashOperator(
        task_id='load',
        bash_command='python dags/load.py',
    )

    date_dim_transform = PostgresOperator(
        task_id='date_dim_transform',
        postgres_conn_id='redshift',
        sql='dags/sql/date_dim_transform.sql',
        autocommit=True)

    store_dim_transform = PostgresOperator(
        task_id='store_dim_transform',
        postgres_conn_id='redshift',
        sql='dags/sql/store_dim_transform.sql',
        autocommit=True)

    customer_dim_transform = PostgresOperator(
        task_id='customer_dim_transform',
        postgres_conn_id='redshift',
        sql='dags/sql/customer_dim_transform.sql',
        autocommit=True)

    film_dim_transform = PostgresOperator(
        task_id='film_dim_transform',
        postgres_conn_id='redshift',
        sql='dags/sql/film_dim_transform.sql',
        autocommit=True)

    sales_fact_transform = PostgresOperator(
        task_id='sales_fact_transform',
        postgres_conn_id='redshift',
        sql='dags/sql/sales_fact_transform.sql',
        autocommit=True)

    extract >> load >> [date_dim_transform, store_dim_transform,
                        customer_dim_transform, film_dim_transform] >> sales_fact_transform
