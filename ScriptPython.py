from sqlalchemy import create_engine
import pandas as pd
import pymysql
import time

engine = create_engine("mysql+pymysql://root@localhost/ETABLISSEMENT")

def import_csv(link, table, date):
    print("lecture des données")
    start_time = time.time()
    csize = 300000
    df = pd.read_csv(link, compression='zip', chunksize= csize, parse_dates= date)
    print("Données Lu")
    i = csize
    for chunk in df:
        chunk.to_sql(table, if_exists='append',index= False, con= engine)
        i+= csize
        print(i)
        
        print("Temps d execution : %s secondes ---" % (time.time() - start_time))
    
import_csv('https://www.data.gouv.fr/fr/datasets/r/09af65ff-c1c6-40bb-bfcb-b80f7ac93b72', 'hist_etab', ['dateFin','dateDebut'] )
