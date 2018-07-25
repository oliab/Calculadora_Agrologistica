import sys
#!/usr/bin/python
# coding=utf-8

def scrapMex(prod, PrePor, aqAnio, aqMes, aqDia, dqAnio, dqMes, dqDia, ori, dest):
        #Función que calcula el precio de cierto producto de alguna ciudad de origen y hacia algún punto de venta dentro de México
        #La ventana de tiempo es definida por el usuario
        #Parámetros:
        #prod: dato tipo int
        #PrePor: dato tipo int
        #aqAnio: dato tipo int
        #aqMes: dato tipo int
        #aqDia: dato tipo int
        #dqAnio: dato tipo int
        #dqMes: dato tipo int
        #dqDia: dato tipo int
        #ori: dato tipo int
        #dest: dato tipo int
    from bs4 import BeautifulSoup
        #BeautifulSoup: paquetería de Python que permite leer la estructura HTML para poder ser escrapeada por Python
    import urllib2
    import pandas as pd
    url_to_scrape='http://www.economia-sniim.gob.mx/2010prueba/FrutasFec.asp?Cons=D&prod='+str(prod)+'&dest='+dest+'&ori='+str(ori)+'&dqDia='+str(dqDia)+'&dqMes='+str(dqMes)+'&dqAnio='+str(dqAnio)+'&aqDia='+str(aqDia)+'&aqMes='+str(aqMes)+'&aqAnio='+str(aqAnio)+'&PrePor='+PrePor+'&Formato=Nor&submit=Ver+Resultados'
        #Dirección url de la página que realizará la consulta
    print url_to_scrape
    response = urllib2.urlopen(url_to_scrape)
    html = response.read()
    soup = BeautifulSoup(html)
    table=soup.findAll("table")
    error=-5
    for i in range(1,len(table)):
        try:
            if table[i]['id'] =='error':
                error=i
        except Exception, e:
            pass
                #print table[i]['id']
    if error!=-5:
        if table[error].findAll('td')[0].text==u'\nNo encontr\xf3 informaci\xf3n para los datos indicados\n':
            print u'\nNo encontr\xf3 informaci\xf3n para los datos indicados\n'
    else:
        for i in range(1,len(table)):
            try:
                if table[i]['id'] =='Datos':
                    indice=i
            except Exception, e:
                pass
        df=pd.read_html(str(table[indice]))[0]
        df.columns = ['destino', 'presentacion', 'fecha', 'pmin', 'pmax', 'pfrec', 'observaciones']   
        df1 = df.iloc[6:] 
        df1.reset_index(drop=True, inplace=True)  
        destino = df1['destino'][0]
        for x in xrange(len(df1)):
            if df1['destino'][x] == 'Sinaloa':
                df1.iloc[x]['destino']=destino
            else:
                destino=df1['destino'][x]
        df1=df1[['destino', 'presentacion', 'fecha', 'pmin', 'pmax', 'pfrec']]
        df1=df1.dropna()
        for destino in df1['destino'].unique():
            aguas=df1[df1['destino'] == destino]
            print destino
            for x in aguas['presentacion'].unique():
                trece=aguas[aguas['presentacion']==x]
                print x, pd.to_numeric(trece['pfrec']).mean()
            #Método que guarda la información buscada en un dataframe para su visualización y manipulación para después ser presentado
            #Regresa el promedio del precio del producto seleccionado, dato tipo float.
if __name__ == "__main__":
     scrapMex(int(sys.argv[1:][0]),str(sys.argv[1:][1]),int(sys.argv[1:][2]),int(sys.argv[1:][3]), int(sys.argv[1:][4]), int(sys.argv[1:][5]), int(sys.argv[1:][6]), int(sys.argv[1:][7]), int(sys.argv[1:][8]), str(sys.argv[1:][9]))

