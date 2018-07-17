library(dplyr)
library(stringr)
library(readr)

siap_2017 <- read_csv("C:/Users/paty/Desktop/bases_sam/Cierre_agricola_mun_2017.csv", locale = locale(asciify = TRUE))

siap_2017 <- siap_2017 %>%
  arrange(Nomcultivo)

unique(siap_2017$Nomcultivo)

siap_sel <- c("Trigo grano", "C\xe1rtamo", "Higuerilla", "Sorgo grano", "Avena forrajera en verde", "Cebada grano", "Lim\xf3n", "Fresa", "Nuez",
             "Ma\xedz grano", "Frijol", "Canola", "Arroz palay", "Jatropha", "Algod\xf3n hueso", "Tomate rojo (jitomate)", "Uva", "Ar\xe1ndano", 
             "Vainilla", "Caf\xe9 cereza", "Cacao", "Soya", "Pi\xf1a", "Agave", "Chile verde", "Naranja", "Papaya", "Zarzamora", "Frambuesa", 
             "Ca\xf1a de az\xfacar", "Girasol", "Manzana", "Aguacate", "Mango", "Toronja (pomelo)", "Palma africana o de aceite")


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


  



