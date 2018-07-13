library(curl)
library(jsonlite)
## Obtención de costos de gasolina

## Para la obtención de costos de gasolina usaremos una conexión a la base de datos del INEGI. En esta Base
## Podemos encontrar los precios promedios de los diferentes tipos de combustible que hay en el país.
## Por el momento este dato nos permitirá hacer el costo del gasto en combustible.

## Para poder conectarte a la base de datos del INEGI requieres un Token. En este caso

token<-"IMw3vu3s-tSkM-7Fbx-13si-V1hLQP103alN"

## El URL donde obtenemos la información es:

url<-paste0("http://gaia.inegi.org.mx/sakbe/wservice?make=CM&type=json&key=",token)

con<-curl(url)
open(con)

out <- readLines(con, n = 3)

fromJSON(out)
