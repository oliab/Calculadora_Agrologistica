library(dplyr)
library(stringr)
library(readr)
library(tidyr)

siap_2017 <- read.csv("C:/Users/paty/Desktop/bases_sam/Cierre_agricola_mun_2017.csv", fileEncoding = "latin1")

siap_2017$Nomcultivo <- as.character(siap_2017$Nomcultivo)

siap_2017 <- siap_2017 %>%
  arrange(Nomcultivo)

unique(siap_2017$Nomcultivo)

siap_sel <- c("Trigo grano", "Cártamo", "Higuerilla", "Sorgo grano", "Avena forrajera en verde", "Cebada grano", "Limón", "Fresa", "Nuez",
             "Maíz grano", "Frijol", "Canola", "Arroz palay", "Jatropha", "Algodón hueso", "Tomate rojo (jitomate)", "Uva", "Arándano", 
             "Vainilla", "Café cereza", "Cacao", "Soya", "Pi\xf1a", "Agave", "Chile verde", "Naranja", "Papaya", "Zarzamora", "Frambuesa", 
             "Caña de azúcar", "Girasol", "Manzana", "Aguacate", "Mango", "Toronja (pomelo)", "Palma africana o de aceite")


siap_2017_select <- filter(siap_2017, siap_2017$Nomcultivo %in% siap_sel)

unique(siap_2017_select$Nomcultivo)

## generar claves geo ##
siap_2017_select$cve_ent <- str_pad(siap_2017_select$Idestado,2,pad = 0)
siap_2017_select$cve_mun <- paste0(siap_2017_select$cve_ent,str_pad(siap_2017_select$Idmunicipio,3,pad = 0))

final_sembrada<-siap_2017_select %>%
  select(Idestado,Nomestado,Idcader,Nomcader,Idmunicipio,Nommunicipio,Nomunidad,Nomcultivo,Sembrada,cve_mun) %>% 
  group_by(cve_mun,Nomcultivo) %>%
  summarise(suma=sum(Sembrada)) %>%
  spread(Nomcultivo,suma)

write.csv(final_sembrada, file = "C:/Users/paty/Desktop/bases_sam/sembrada.csv",na = "")

final_volumen<-siap_2017_select %>%
  select(Idestado,Nomestado,Idcader,Nomcader,Idmunicipio,Nommunicipio,Nomunidad,Nomcultivo,Volumenproduccion,cve_mun) %>% 
  group_by(cve_mun,Nomcultivo) %>%
  summarise(suma=sum(Volumenproduccion)) %>%
  spread(Nomcultivo,suma)

write.csv(final_volumen, file = "C:/Users/paty/Desktop/bases_sam/volumen.csv",na = "")

final_Precio<-siap_2017_select %>%
  select(Idestado,Nomestado,Idcader,Nomcader,Idmunicipio,Nommunicipio,Nomunidad,Nomcultivo,Precio,cve_mun) %>% 
  group_by(cve_mun,Nomcultivo) %>%
  summarise(suma=sum(Precio)) %>%
  spread(Nomcultivo,suma)

write.csv(final_Precio, file = "C:/Users/paty/Desktop/bases_sam/precio.csv",na = "")

final_Valor<-siap_2017_select %>%
  select(Idestado,Nomestado,Idcader,Nomcader,Idmunicipio,Nommunicipio,Nomunidad,Nomcultivo,Valorproduccion,cve_mun) %>% 
  group_by(cve_mun,Nomcultivo) %>%
  summarise(suma=sum(Valorproduccion)) %>%
  spread(Nomcultivo,suma)

write.csv(final_Valor, file = "C:/Users/paty/Desktop/bases_sam/valor.csv",na = "")


  



