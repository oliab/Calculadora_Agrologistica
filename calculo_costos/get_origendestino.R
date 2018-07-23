library(tidyverse)
library(httr)
### origen-destino


token<-"IMw3vu3s-tSkM-7Fbx-13si-V1hLQP103alN"

get_ubicaciones<-function(busqueda){
  url<-paste0("http://gaia.inegi.org.mx/sakbe/wservice?make=SD&buscar=",busqueda,"&type=json&key=",token)
  data<-GET(url)
  this.raw.content <- rawToChar(data$content)
  
  data<-fromJSON(this.raw.content) %>% data.frame()
  return(data)
}

obtener_id<-function(busqueda,fila){
  id<-busqueda$id_dest[fila]
  return(id)
}

get_coord<-function(lon,lat){
  url<-paste0("http://gaia.inegi.org.mx/sakbe/wservice?make=IL&x=",lon,"&y=",lat,"&escala=100000&type=json&key=",token)
  data<-GET(url)
  
  this.raw.content <- rawToChar(data$content)
  data<-fromJSON(this.raw.content) %>% data.frame()
  return(data)
}

get_coord("-99.0061961","19.618094")
