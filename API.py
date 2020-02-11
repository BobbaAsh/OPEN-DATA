#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 20 09:57:17 2020

@author: bobba
"""

import pandas as pd
from sqlalchemy import create_engine


engine = create_engine('mysql+pymysql://root@localhost/ETABLISSEMENT')


def start() :
    a = "0"
    running = True
    while running == True :
        a = input("Bienvenue!\n\nTapez 1 pour afficher toutes les entreprises sur Marseille .\nTapez 2 pour rentrer un code postal et afficher le nombre d'entreprises présente dans l'arrondisement.\nTapez 3 pour entrer un secteur d'activités et afficher le nombre d'entreprises dans ce secteur.\nTapez 4 pour entrer un arrondisement et un secteur d'activité.\nTapez 5 pour savoir la Durée de vie moyenne des entreprises.\nTapez 6 pour quitter\n")
        if a == "1" :
            print("Je vais vous afficher le nombre d'entreprises sur Marseille.")
            df = pd.read_sql("SELECT * FROM alias_etab_marseille",con=engine)
            print(df)
        elif a == "2" :
            print("vous venez de choisir le second choix.")
            ard = input("Entrez un code postal : ")
            df = pd.read_sql_query('SELECT count(*) FROM alias_etab_marseille WHERE codePostalEtablissement = "%s"' % (ard), engine)
            print(df)
        elif a == "3":
            print("vous venez de choisir le troisième choix.")
            sect = input("Entrez un secteur d'activité : ")
            df = pd.read_sql_query('SELECT count(*) FROM alias_etab_marseille WHERE LIB_NAP600= "%s"' % (sect), engine)
            print(df)
        elif a == "4" : 
            print("vous venez de choisir le quatrième choix.")
            sect = input("Entrez un secteur d'activité : ")
            ard = input("Entrez un code postal : ")
            df = pd.read_sql_query('SELECT count(*) FROM alias_etab_marseille WHERE LIB_NAP600= "%s" AND codePostalEtablissement = "%s"' % (sect, ard), engine)
            print(df)
        elif a == "5" :
          ard = input("Veuillez entrer un code postal: ")
          df = pd.read_sql_query('SELECT AVG(timestampdiff(year, datecreationetablissement, datedebut)) AS ddvEtablissement FROM ddv WHERE codepostaletablissement = "%s"' %  (ard), engine)
          print(df)
        elif a == "6" :
            quitter = "Y" or "y" 
            if quitter == "Y" or quitter == "y":
                print("Fermeture")
                running = False
        else :
            start()
           
            
start()