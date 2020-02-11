#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan  7 15:51:34 2020

@author: bobba
"""

from sqlalchemy import create_engine
import pandas as pd
import time

engine = create_engine("mysql+pymysql://root@localhost/ETABLISSEMENT")

def import_xls(link, table):
    print("lecture des données")
    start_time = time.time()
    df = pd.read_excel(link, skiprows=[0])
    print("Données Lu")
    print("Temps d execution : %s secondes ---" % (time.time() - start_time))   
    df.to_sql(table, if_exists='append',index= False, con= engine)
import_xls('/home/bobba/code/Simplon_DATA/Exercices/OPEN DATA/naf2003_liste_n1.xls', 'nom_naf2003' )
    