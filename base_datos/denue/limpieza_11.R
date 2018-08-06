
setwd("/Users/usuario/Documents/proyectos/Calculadora_Agrologistica/base_datos/denue")

##abro denue
library(readr)
library(stringr)
library(tidyverse)
denue <- read_csv("~/Documents/proyectos/Calculadora_Agrologistica/base_datos/denue/denue_00_11_csv/conjunto_de_datos/denue_inegi_11_.csv")
#"Servicios de fumigación agrícola" 

denue1<-denue %>% 
  filter(nombre_act=="Beneficio de productos agrícolas") 

fumigacion<- denue %>% 
  filter(nombre_act=="Servicios de fumigación agrícola") 

empacadora<- c("EMPACADORA", "EMPAQUE")
bodega<-c("BODEGA","ALMACENAMIENTO","ALMACEN")
proceso<-c("PROCESOS","PROCESADORA","PRODUCCIÓN")
comer<-c("COMERCIALIZADORA","COMERCIALIZACIÓN","COMERCIO","VENTA")



denue1<-denue1 %>%
  mutate(tipo_comercio=ifelse(str_detect(denue1$nom_estab,"EMPACADORA"),"Empacadora",
                              ifelse(str_detect(denue1$nom_estab,"BODEGA"),"Bodega",
                                     ifelse(str_detect(denue1$nom_estab,"FRIGORÍFICO"),"Refrigeracion",
                                            if_else(str_detect(denue1$nom_estab,"PROCESADORA"),"Procesamiento",
                                                    ifelse(str_detect(denue1$nom_estab,"COMERCIALIZADORA"),"Comercializadora",
                                                           if_else(str_detect(denue1$nom_estab,"EMPAQUE"),"Empacadora",
                                                                   ifelse(str_detect(denue1$nom_estab,"ALMACÉN"),"Bodega",
                                                                          ifelse(str_detect(denue1$nom_estab,"ALMACEN"),"Bodega",
                                                                                 ifelse(str_detect(denue1$nom_estab,"PRODUCCIÓN"),"Procesamiento",
                                                                                        ifelse(str_detect(denue1$nom_estab,"PROCESO"),"Procesamiento",
                                                                                               ifelse(str_detect(denue1$nom_estab,"COMERCIO"),"Comercializadora",
                                                                                                      if_else(str_detect(denue1$nom_estab,"VENTA"),"Comercializadora",
                                                                                                              ifelse(str_detect(denue1$nom_estab,"SELECCION"),"V.A.",
                                                                                                                     ifelse(str_detect(denue1$nom_estab,"TOSTADO"),"V.A.",
                                                                                                                            ifelse(str_detect(denue1$nom_estab,"ENCERADORA"),"V.A.",
                                                                                                                                   ifelse(str_detect(denue1$nom_estab,"CEPILLADORA"),"V.A.",
                                                                                                                                          ifelse(str_detect(denue1$nom_estab,"LIMPIADORA"),"V.A.",
                                                                                                                                                 ifelse(str_detect(denue1$nom_estab,"LIMPIEZA"),"V.A.",
                                                                                                                                                        ifelse(str_detect(denue1$nom_estab,"CRIBADORA"),"V.A.",
                                                                                                                                                               ifelse(str_detect(denue1$nom_estab,"QUEBRADORA"),"V.A.",
                                                                                                                                                                      ifelse(str_detect(denue1$nom_estab,"DESHUESADERO"),"V.A.",
                                                                                                                                                                             ifelse(str_detect(denue1$nom_estab,"PELADERO"),"V.A.",
                                                                                                                                                                                    ifelse(str_detect(denue1$nom_estab,"LAVADORA"),"V.A.","Otra"))))))))))))))))))))))))



denue2 <- read_csv("~/Documents/proyectos/Calculadora_Agrologistica/base_datos/denue/denue_00_54_csv/conjunto_de_datos/denue_inegi_54_.csv")
View(denue_inegi_54_)

denue2 %>% 
  filter(nombre_act=="Servicios de investigación científica y desarrollo en ciencias naturales y exactas, ingeniería, y ciencias de la vida, prestados por el sector privado") %>%
  View()
denue3 <- read_csv("~/Documents/proyectos/Calculadora_Agrologistica/base_datos/denue/denue_00_48-49_csv/conjunto_de_datos/denue_inegi_48-49_.csv")

transporte<-denue3 %>%
  filter(nombre_act== "Autotransporte local de productos agrícolas sin refrigeración" |nombre_act=="Autotransporte foráneo de productos agrícolas sin refrigeración" |
           nombre_act=="Almacenamiento de productos agrícolas que no requieren refrigeración" | nombre_act=="Almacenamiento con refrigeración" |
           nombre_act=="Autotransporte local con refrigeración" | nombre_act=="Autotransporte local con refrigeración" |
           nombre_act=="Autotransporte foráneo con refrigeración") %>%
  mutate(tipo_comercio="Transporte y almacenamiento")



produccion<-denue1 %>%
  filter(tipo_comercio=="Procesamiento" |tipo_comercio=="Otra") 

p1<-denue %>%
  filter(nombre_act=="Servicios de fumigación agrícola"  ) %>%
  mutate(tipo_comercio="Fumigacion")

produccion<-rbind(produccion,p1)

write.csv(produccion,"produccion.csv")

transformacion<-denue1 %>%
  filter(tipo_comercio=="Empacadora" |tipo_comercio=="V.A.")

write.csv(transformacion,"transformacion.csv")

comer<-denue1 %>%
  filter(tipo_comercio=="Bodega" |tipo_comercio=="Refrigeracion" |tipo_comercio=="Comercializadora")

comer<-rbind(comer,transporte)

write.csv(comer,"comercializadora.csv")

