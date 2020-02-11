#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan  7 17:09:39 2020

@author: utilisateur
"""
import pandas as pd
from sqlalchemy import create_engine


engine = create_engine('mysql+pymysql://root@localhost/ETABLISSEMENT')

#df = pd.read_excel("/home/utilisateur/Téléchargements/naf1993_liste_n1.xls", delimiter='|',skiprows=1)
#df.to_sql('naf1993sections', con=engine, if_exists='append', index=False)

def importexcel(fichier_xls, table_sql, rows_to_skip):
    
    df = pd.read_excel(fichier_xls, delimiter='|',skiprows=rows_to_skip)
    
    df.to_sql(table_sql, con=engine, if_exists='append', index=False)
    
    return print('tableau', table_sql, 'has been filled')

naf1993_niveaux = 'naf1993_5_niveaux.xls'
naf2003_niveaux = 'naf2003_n1-5.xls'
naf2008_niveaux = 'naf2008_5_niveaux.xls'

naf1993_sections = 'naf1993_liste_n1.xls'
naf2003_sections = 'naf2003_liste_n1.xls'
naf2008_sections = 'naf2008_liste_n1.xls'

nap1973 = 'NAP_1973_1993.xls'



importexcel(naf1993_sections, 'naf1993sections', 1)
importexcel(naf1993_niveaux, 'naf1993niveaux', 1)

importexcel(naf2003_sections, 'naf2003sections', 1)
importexcel(naf2003_niveaux, 'naf2003niveaux', 1)

importexcel(naf2008_sections, 'naf2008sections', 2)
importexcel(naf2008_niveaux, 'naf2008niveaux', 0)

importexcel(nap1973, 'nap1973_1993',0) 