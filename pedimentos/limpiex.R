
library(readr)
t501 <- read_delim("datos/t501.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t501)
colnames(t501) <- nombres_501 



 #######
t502 <- read_delim("datos/t502.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t502)
colnames(t502) <- nombres_502


#####
t503 <- read_delim("datos/t503.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t503)
colnames(t503) <- nombres_503


#####
t504 <- read_delim("datos/t504.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t504)
colnames(t504) <- nombres_504



#####
t505 <- read_delim("datos/t505.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t505)
colnames(t505) <- nombres_505



#####
t506 <- read_delim("datos/t506.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t506)
colnames(t506) <- nombres_506


##### FALTA
t507 <- read_delim("datos/t507.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t507)
colnames(t507) <- nombres_507

#####
t509 <- read_delim("datos/t509.txt", "|", 
                   escape_double = FALSE, trim_ws = TRUE, col_names=FALSE)
View(t509)
colnames(t509) <- nombres_509

