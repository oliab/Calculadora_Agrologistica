
setwd("/Users/usuario/Documents/proyectos/Calculadora_Agrologistica/base_datos/denue")

##abro denue
library(readr)
library(stringr)
denue1 <- read_csv("~/Documents/proyectos/Calculadora_Agrologistica/base_datos/denue/denue_00_43_csv/conjunto_de_datos/denue_inegi_43_.csv")

denue1 <- denue1 %>% 
  filter(nombre_act=="Comercio al por mayor de fertilizantes, plaguicidas y semillas para siembra" | nombre_act=="Comercio al por mayor de maquinaria y equipo agropecuario, forestal y para la pesca" ) %>%
  distinct(nom_estab, .keep_all = TRUE) 

write.csv(denue1,"abasto_insumos.csv")
