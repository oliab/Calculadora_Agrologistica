library(tidyverse)
library(httr)
library(jsonlite)
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


hacer_ruta<-function(id_origen,tipo_ruta,tipo_vehiculo,ejes){
  id_origen<-as.character(id_origen)
  tipo_ruta<-as.character(tipo_ruta)
  tipo_vehiculo<-as.character(tipo_vehiculo)
  ejes<-as.character(ejes)
  url<-paste0("http://gaia.inegi.org.mx/sakbe/wservice?make=CR&dest_i=",id_origen,"&id_f=99589&source_f=218261&target_f=158343&p=",tipo_ruta,"&v=",tipo_vehiculo,"&e=",ejes_totales,"&type=json&key=",token)
  data<-GET(url)
  this.raw.content <- rawToChar(data$content)
  
  data<-fromJSON(this.raw.content) %>% data.frame()
  return(data)
  
}
