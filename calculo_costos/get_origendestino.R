library(tidyverse)
library(httr)
### origen-destino

### Busqueda de destino, en este caso Central de Abastos Iztapalapa, por ejemplo.
busqueda<-"abasto"

url<-paste0("http://gaia.inegi.org.mx/sakbe/wservice?make=SD&buscar=",busqueda,"&type=json&key=",token)
data<-GET(url)
this.raw.content <- rawToChar(data$content)

data<-fromJSON(this.raw.content) %>% data.frame()
id_dest<-data$id_dest[2] ## Esto se tiene que solucionar con un scroll- down en la app. Por ahora es manual.


## Busqueda de origen, En este caso, Uruapan, Michoacán.

busqueda<-"Uruapan"

url<-paste0("http://gaia.inegi.org.mx/sakbe/wservice?make=SD&buscar=",busqueda,"&type=json&key=",token)
data<-GET(url)
this.raw.content <- rawToChar(data$content)

data<-fromJSON(this.raw.content) %>% data.frame()
id_origen<-data$id_dest[1] ## Esto se tiene que solucionar con un scroll- down en la app. Por ahora es manual.
