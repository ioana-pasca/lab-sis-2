#!/usr/bin/python3

# -----------------------------------------------------------------
#    File: pima_res.py
#    Author: Ioana Carmen Pasca
#    Date: 04/03/2023
#    Goal: Process the data of an excel table
# ------------------------------------------------------------------

import argparse
import sys
import pandas as pd

# Arguments
parser = argparse.ArgumentParser(description='process some integers.')
parser.add_argument('archivo', metavar='Prima.csv', type=str, help='file with the info')
parser.add_argument('-m', '--mean', action='store_true', help='prints the name of the columns with numeric values and calculates their average')
parser.add_argument('-b', '--bool', action='store_true', help='prints the name of the columns with boolean values (yes or no)')
args = parser.parse_args()
df = pd.read_csv(args.archivo)

if args.mean:
    # Prints the average of all the values of each column and the column name
    num_columnas = df.select_dtypes(include=['float64','int64']).columns.tolist()

    for col in num_columnas:
        mean = df[col].mean()
        print(f"{col}:\t{mean}")

if args.bool:
    # Prints the name of the column with boolean values and its count
    yes_count = df['type'].str.count('Yes').sum()
    no_count = df['type'].str.count('No').sum()

    print(f"{'type'}:\n\tYES = {yes_count}\n\tNo = {no_count}")

sys.exit() # Exit successfully