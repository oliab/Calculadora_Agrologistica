
library(readr)
library(readxl)
library(stringr)
library(tidyverse)

apendice_1 <- read_excel("apendices/apendice_1.xlsx") %>% 
  mutate(cve=str_pad(cve,2,pad="0")) %>% 
  mutate(secc=replace_na(secc,0))%>%
  mutate(cve=paste0(cve,secc)) %>% 
  select(cve,valor)
apendice_2 <- read_excel("apendices/apendice_2.xlsx")
apendice_3 <- read_excel("apendices/apendice_3.xlsx")
apendice_4 <- read_excel("apendices/apendice_4.xlsx")
apendice_5 <- read_excel("apendices/apendice_5.xlsx")
apendice_10 <- read_excel("apendices/apendice_10.xlsx")
apendice_14 <- read_excel("apendices/apendice_14.xlsx")
apendice_15 <- read_excel("apendices/apendice_15.xlsx")


####

t501 <- read_delim("datos/noviembre/t501.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
colnames(t501) <- nombres_501


t501 <- t501 %>% 
  left_join(apendice_1, by=c("cve_secc_aduanera_despacho"="cve")) %>% 
  rename(secc_aduanera_despacho=ncol(t501)+1) %>% 
  mutate(cve_tipo_operacion=ifelse(cve_tipo_operacion==1,"Importacion","Exportacion")) %>%
  left_join(apendice_2,by=c("cve_documento"="cve")) %>% 
  rename(documento=ncol(t501)+2) %>% 
  left_join(apendice_1,by=c("cve_aduana_entrada"="cve")) %>%
  rename(aduana_entrada=ncol(t501)+3) %>%
  left_join(apendice_3,by=c("cve_transporte_salida"="cve")) %>% 
  rename(transporte_salida=ncol(t501)+4) %>% 
  left_join(apendice_3,by=c("cve_transporte_entrada"="cve")) %>% 
  rename(transporte_entrada=ncol(t501)+5) %>% 
  left_join(apendice_3,by=c("cve_medio_transporte"="cve")) %>% 
  rename(medio_transporte=ncol(t501)+6) %>%
  left_join(apendice_15,by=c("cve_destino"="cve")) %>% 
  rename(destino_mercancia=ncol(t501)+7) %>%
  mutate(cve_tipo_pedimento=ifelse(cve_tipo_pedimento==1,"Normal","Rectificacion"))


 #######
t502 <- read_delim("datos/noviembre/t502.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t502)
colnames(t502) <- nombres_502

t502 <-t502 %>% 
  left_join(apendice_1,by=c("cve_secc_aduanera_despacho"="cve")) %>% 
  rename(secc_aduanera_despacho=ncol(t502)+1) %>% 
  left_join(apendice_4,by=c("cve_pais_transporte"="cve")) %>% 
  rename(pais_transporte=ncol(t502)+2)


#####
t503 <- read_delim("datos/noviembre/t503.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
colnames(t503) <- nombres_503
View(t503)


#####
t504 <- read_delim("datos/noviembre/t504.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
colnames(t504) <- nombres_504
View(t504)

t504<-t504 %>% 
  left_join(apendice_10, by=c("cve_tipo_contenedor"="cve")) %>% 
  rename(tipo_contenedor=ncol(t504)+1)



#####
t505 <- read_delim("datos/noviembre/t505.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t505)
colnames(t505) <- nombres_505

t505<-t505 %>% 
  left_join(apendice_14,by=c("cve_termino_facturacion"="cve")) %>% 
  rename(termino_facturacion=ncol(t505)+1) %>% 
  left_join(apendice_5,by=c("cve_moneda_facturacion"="cve")) %>% 
  rename(pais_moneda=ncol(t505)+2) %>% 
  left_join(apendice_4,by=c("cve_pais_facturacion"="cve")) %>% 
  rename(pais_facturacion=ncol(t505)+3)


#####
t506 <- read_delim("datos/noviembre/t506.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t506)
colnames(t506) <- nombres_506
t506<-t506 %>% 
  mutate(tipo_fecha=ifelse(cve_tipo_fecha==1,"Entrada",
                           ifelse(cve_tipo_fecha==2,"Pago",
                                ifelse(cve_tipo_fecha==3,"Extraccion",
                                       ifelse(cve_tipo_fecha==5,"Presentacion",
                                              ifelse(cve_tipo_fecha==6,"IMP EUA/CAN","ORIGINAL"))))))


##### FALTA
t507 <- read_delim("datos/noviembre/t507.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t507)
colnames(t507) <- nombres_507

#####
t509 <- read_delim("datos/t509.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t509)
colnames(t509) <- nombres_509

#####
t510 <- read_delim("datos/t510.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t510)
colnames(t510) <- nombres_510


#####
t512 <- read_delim("datos/t512.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t512)
colnames(t512) <- nombres_512


