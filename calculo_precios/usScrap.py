import sys
#/usr/bin/python
#coding=utf-8

def scrapUs(prod, dest, dqDia, dqMes, dqAnio, aqDia, aqMes, aqAnio):
	#Función que calcula el precio promedio de productos en el mercado exterior
	#Parámetros:
	#prod: int
	#dest: int
	#dqDia: int
	#dqMes: int
	#dqAnio: int
	#aqDia: int
	#aqMes: int
	#aqAnio: int
    from bs4 import BeautifulSoup
	#BeautifulSoup, paquetería de Python que permite leer la estructura HTML para luego ser escrapeada
    import urllib2
    import pandas as pd
    url_to_scrape='http://www.economia-sniim.gob.mx/2010prueba/ExtFrutasFec.asp?Cons=D&prod=%'+str(prod)+'&dest='+dest+'&ori=O189&dqDia='+str(dqDia)+'&dqMes='+str(dqMes)+'&dqAnio='+str(dqAnio)+'&aqDia='+str(aqDia)+'&aqMes='+str(aqMes)+'&aqAnio='+str(aqAnio)+'&Formato=Nor&submit=Ver+Consulta'
    #Dirección url del sitio de la página a la que se realizará la consulta
    #url_to_scrape='http://www.economia-sniim.gob.mx/2010prueba/ExtFrutasFec.asp?Cons=D&prod=%4080&dest=T&ori=O189&dqDia=1&dqMes=2&dqAnio=2016&aqDia=28&aqMes=2&aqAnio=2016&Formato=Nor&submit=Ver+Consulta'
    response = urllib2.urlopen(url_to_scrape)
    html = response.read()
    soup = BeautifulSoup(html)
    table=soup.findAll("table")
    error=-5
	
    print url_to_scrape
    for i in range(1,len(table)):
        try:
            if table[i]['id'] =='error':
                error=i

        except Exception, e:
            pass
    print "error", error
    if error!=-5:
	print "way"
        if table[error].findAll('td')[0].text==u'\nNo encontr\xf3 informaci\xf3n para los datos indicados\n':
            print u'\nNo encontr\xf3 informaci\xf3n para los datos indicados\n'
    else:
	print "entro"
        for i in range(1,len(table)):
            try:
                if table[i]['id'] =='Datos':
                    indice=i
            except Exception, e:
                pass
        df=pd.read_html(str(table[indice]))[0]
	#Se almacena la información obtenida de la página en un dataframe para su análisis
        df1 = df.iloc[7:]
        df1.columns = ['destino', 'presentacion', 'tamano', 'fecha', 'pmin', 'pmax', 'observaciones']
        df1.reset_index(drop=True, inplace=True)  
        df1['variedad']=''
        destino=0
        var=1
        lugar=df1['destino'][destino]
        for i in df1.index:
            if df1['destino'].iloc[i]==u'\xc2':
                df1['destino'].iloc[i]=lugar
                df1['variedad'].iloc[i]=variedad
                if df1['tamano'][i]==u'\xc2':
                    df1['tamano'][i]=tipo
                else:
                    tipo=df1['tamano'][i]
                if df1['presentacion'][i]==u'\xc2':
                    df1['presentacion'][i]=presentacion
                else:
                    presentacion=df1['presentacion'][i]
            elif df1['destino'].iloc[i+1]==u'\xc2':
                presentacion=df1['presentacion'][i]
                tipo=df1['tamano'][i]
                df1['destino'].iloc[i]=lugar
                df1['variedad'].iloc[i]=variedad
                pass
            elif df1['destino'].iloc[i+2]==u'\xc2':
                variedad=df1['destino'].iloc[i]
                var=i
            else:
                destino=i
                lugar=df1['destino'][destino]
        df1=df1[['destino', 'presentacion', 'tamano', 'fecha', 'pmin', 'pmax', 'variedad']]
        df1=df1.dropna()
        for destino in df1['destino'].unique():
            mat=df1[df1['destino'] == destino]
            print '------'+destino+'-------'
            for x in mat['presentacion'].unique():
                result=mat[mat['presentacion']==x]
                print x
                for y in result['tamano'].unique():
                    result=mat[mat['tamano']==y]
                    print '   '+ y, pd.to_numeric(result['pmin']).mean()
		#Regresa un dataframe con el precio promedio, tipo de dato: float

if __name__ == "__main__":
     scrapUs(int(sys.argv[1:][0]),str(sys.argv[1:][1]),int(sys.argv[1:][2]),int(sys.argv[1:][3]), int(sys.argv[1:][4]), int(sys.argv[1:][5]), int(sys.argv[1:][6]),int(sys.argv[1:][7]))
