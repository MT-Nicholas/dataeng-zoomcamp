#!/usr/bin/env python
# coding: utf-8

import os
import argparse

import pandas as pd
from sqlalchemy import create_engine

from time import time

def main(params):
    
    # use argparse to extract params from the command-line arguments
    user = params.user
    password = params.password
    host = params.host 
    port = params.port 
    db = params.db
    table_name = params.table_name
    url = params.url
    csv_name = 'output.csv'

    # run command on environment terminal
    os.system(f"wget {url} -O {csv_name}")


    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()

    # read file as df to define table with schema
    df = pd.read_csv(csv_name, nrows=100, compression='gzip')

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    # read file as iterator to iterate through chunks
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000, compression='gzip')

    while True: 
        try:
            t_start = time()
            df = next(df_iter)

            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
            
            df.to_sql(name=table_name, con=engine, if_exists='append')

            t_end = time()

            print('inserted another chunk, took %.3f second' % (t_end - t_start))
        except StopIteration:
            print('completed')
            break

if __name__ == '__main__':
    # Parse the command line arguments and calls the main program
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table_name', help='name of the table where we will write the results to')
    parser.add_argument('--url', help='url of the csv file')

    args = parser.parse_args()

    main(args)