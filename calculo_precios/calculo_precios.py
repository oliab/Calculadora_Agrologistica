


from bs4 import BeautifulSoup
        #BeautifulSoup: paquetería de Python que permite leer la estructura HTML para poder ser escrapeada por Python
import urllib3
import pandas as pd
import re



## Para armar el url se requieren dos parametros
## prodC que es el producto
## dest que es la clave de la central

url_to_scrape='http://www.economia-sniim.gob.mx/2010prueba/PreciosHoy.asp?Cons=D&prodC=19605&dest=160&Formato=Xls&submit=Ver+Resultados'
        #Dirección url de la página que realizará la consulta
print(url_to_scrape)



http = urllib3.PoolManager()

response = http.request('GET', url_to_scrape)

soup = BeautifulSoup(response.data, "lxml")
table=soup.findAll("table")
error=-5




for i in range(1,len(table)):
        try:
            if table[i]['id'] =='error':
                error=i
        except Exception as e:
            pass
                #print table[i]['id']
  


if error!=-5:
    if table[error].findAll('td')[0].text==u'\nNo encontr\xf3 informaci\xf3n para los datos indicados\n':
        print (u'\nNo encontr\xf3 informaci\xf3n para los datos indicados\n')
else:
    for i in range(1,len(table)):
        try:
            if table[i]['id'] =='Datos'and pd.read_html(str(table[i]))[0][0][2]== 'Mercados Nacionales:':
                indice=i
        except Exception as e:
            pass




df=pd.read_html(str(table[indice]))[0]
df.columns = ['origen', 'presentacion', 'pmin', 'pmax', 'pfrec', 'observaciones'] 
df["fecha"] =df["origen"][3]
df1 = df.iloc[6:] 
df1=df1.dropna(thresh=5)
df1.reset_index(drop=True, inplace=True)  



for i in range(len(df1)):
    if df1["presentacion"][i]== "Kilogramo":
        df1["presentacion"][i]=1
    else:
        df1["presentacion"][i]=re.findall(r'\d+',df1['presentacion'][i])[0]



df1["precio_kilo"]=pd.to_numeric(df1["pfrec"])/pd.to_numeric(df1["presentacion"])
df1



df1["precio_kilo"].mean()







