# Proyecto de mapeo

## Introducción

Esta sección tiene como objetivo el mapeo de los **38 cultivos estratégicos** que se definen en el documento de **Planeación Agrícola Nacional 2017-2030**

Para lograr esto se hizo una búsqueda exhaustiva en diferentes fuentes de información para encontrar datos que nos permitan saber la cantidad de **hectáreas cultivadas** y poder georeferenciar esta información.

Los mapas generados se encuentran la carpeta *mapas/*  

## Descripción de las bases consultadas

Para encontrar la información de los 38 cultivos estratégicos se revisaron distintas fuentes de información. A continuación se presenta un breve reporte de estas bases:

### Censo Agropecuario y Ejidal INEGI, actualización 2016

Se revisó el **Censo Agropecuario y Ejidal INEGI en su actualización de 2016** para ver si podiamos obtener información sobre los cultivos estratégicos. Sin embargo la información que arroja el censo corresponde a menos de 10 de los cultivos estratégicos, por lo que no se utilizó esta base en este proceso.

Sin embargo esta base de datos puede ser valiosa en caso de que se quiera obtener información sobre:  
- Tipo de riego utilizado.  
- Disponibilidad de agua en terrenos de cultivo.  
- Terrenos de cultivo por tipo de instalación.  

La información correspondiente a al Censo Agropecuario puede ser encontrada en la carpeta *bases_inegi/*  

### Base de datos del SIAP 2017

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

El proceso que se siguió para la geocodificación de los datos fue el sigioente:

- Se filtró la base de datos del SIAP para dejar la información de los 36 cultivos estratégicos que se encontraron ahí.
- Se construyó una clave de municipio de acuerdo al **estándar para datos geográficos del INEGI**
- Se agregó la información de cada uno de los cultivos a nivel municipio.

Esta parte del proceso se puede encontrar en un script de limpieza en la carpeta *limpieza_datos/* ahí mismo se encuentran las bases generadas en este primer proceso agregando por: * hectáreas totales sembradas, valor del cultivo, precio del cultivo* aunque solo se utilizará la de héctareas totales sembradas.  

Una vez realizado esto se utilizó un programa para manejar datos geográficos llamado *Qgis*. En este programa:  

- Se cruzó la información de los cultivos con el **marco geoestadístico del INEGI**.   
- Se generaron los mapas estáticos.  

Los datos del marco geoestadístico del INEGI se pueden encontrar en la carpeta *cartografía/*.
El ambiente de trabajo de Qgis se puede encontrar en la carpeta *ambiente_gis*.

## Mapas dinámicos

Propuesta de mapas dinámicos con información de actores de cadenas logísticas.

















