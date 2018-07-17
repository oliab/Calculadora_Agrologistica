# Proyecto de mapeo

## Introducción

Esta sección tiene como objetivo el mapeo de los **38 cultivos estratégicos** que se definen en el documento de **Planeación Agrícola Nacional 2017-2030**

Para lograr esto se hizo una búsqueda exhaustiva en diferentes fuentes de información para encontrar datos que nos permitan saber la cantidad de **hectáreas cultivadas** y poder georeferenciar esta información.

Los mapas generados se encuentran la carpeta *mapas/*  

## Descripción de las bases consultadas

Para encontrar la información de los 38 cultivos estratégicos se revisaron distintas fuentes de información. A continuación se presenta un breve reporte de estas bases:

### Censo Agropecuario y Ejidal INEGI 2017

Se revisó el **Censo Agropecuario y Ejidal INEGI 2017** para ver si podiamos obtener información sobre los cultivos estratégicos. Sin embargo la información que arroja el censo corresponde a menos de 10 de los cultivos estratégicos, por lo que no se utilizó esta base en este proceso.

Sin embargo esta base de datos puede ser valiosa en caso de que se quiera obtener información sobre:  
- Tipo de riego utilizado.  
- Disponibilidad de agua en terrenos de cultivo.  
- Terrenos de cultivo por tipo de instalación.  

La información correspondiente a al Censo Agropecuario puede ser encontrada en la carpeta *bases_inegi/*  

### Base de datos del SIAP

La base de datos del SIAP es la más completa en cuanto a información de cultivos se refiere. Para el proceso de mapeo se utilizó la superficie sembrada de cada uno de los cultivos en héctareas. Además de esta variable se encontraron otras que pueden ser de interés:  

- Superficie Cosechada.  
- Superficie Siniestrada.  
- Volúmen de producción.  
- Precio (pesos por tonelada).  
- Valor de la producción.  

Esto para un total de **304 diferentes cultivos** incluyendo 36 de los 38 cultivos prioritarios. **ver con el equipo que pasa con los dos faltantes**

Esta información puede ser georeferenciada a diferentes niveles, siendo el nivel muncicipal el más desagregado de todos. De igual manera se encontró la cartografía correspondiente a los *distritos de SAGARPA*

La información de esta base se puede encontrar en *bases_siap/* junto con un diccionario detallado de los datos que se pueden encontrar en la base.

## Proceso























