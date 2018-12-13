
El proyecto de Pedimentos tiene el objetivo de automatizar lo m´s posible el proceso de descarga y limpieza de lo archivos sobre pedimentos.

Actualmente el proceso de desacarga se hace de manera manual desde la siguiente liga:  
*http://omawww.sat.gob.mx/aduanas/Portal/index.html#!/oper_comext*  

Ahí se encuentran publicados los datos de manera mensual. En cada mes se encontrarán los siguientes archivos:  

A nivel pedimento:  
- Datos Generales  
- Transporte de mercancias  
- Guías  
- Contenedores  
- Facturas  
- Fechas de pedimento  
- Contribuciones de pedimento  
- Descargos de mercncia
- Destinatrios de mercancia

A nivel partidas:  
- Partidas  
- Mercancias  
- Permisos de la partida  
- Tasas de contribuciones de la partida  
- Contribuciones

Se puede hacer una relación entre datos a nivel pedimento y a nivel partida. Actualmente proponemos un cruce de todos los datos a nivel pedimento vs. las bases de Partidas y Mercancías que son donde podemos identificar el tipo de mercancía que se está manejando.

Al hacer esto tendrímos la siguiente información disponible:  

- Patente aduanal.- Número de ptente del agente aduanal.  
- Índice.- Campo de uso interno.  
- Clave de sección aduanera.- Clave de la aduana de despacho.  
- Clave de tipo de operación .- Exportación o Importación.  
- Clave de documento.- Régimen definitivo (Exportación definitiva, regularización, retornos, etc.)  
- Clave de aduana de entrada.- Clave de aduana de entrada.
- Tipo de cambio: Tipo de cambio peso/dólar al momento de la transacción.  
- Total de fletes: Importe de fletes.
- Total de seguros.-**
- Total de embalajes: Importe del total de empaques y embalajes, siembre que no esté comprendidos dentro del precio.  
- Total incrementbles.- Importe en moneda nacional de los conceptos que deben incrementarse al precio pagado.  
- Total otros deducibles.- Importe de deducibles.
- Peso bruto de la mercancia.
- Clave Medio de transporte de salida
- Clave Medio de transporte de arribo
- Clave Medio de transporte de salida o arribo
- Clave de tipo de pedimento.- Normal o rectificacion.
- Fecha de pago real.
- Clave de país del transporte.
- Clave de tipo de guía.- Master o House.
- Clave de tipo de contenedor.
- Clave de termino de facturación. Transporte principal pagado, llegada, salida, transporte principal no pagado.
- Clave moneda de facturacion.
- Valor en dólares de la mercancía  
- Valor en moneda extranjera de la mercancía.
- Clave país de facturación.
- Clave de la entidad federativa de facturación. **
- Clave tipo de fecha: Entrada, pago, extracción, presentación.
- Fecha de operación.
- Clave de caso.
- Identificador del caso.
- Umporte de tasa de contribución.
- Clave de la tasa.- CONTRIBUCIONES, CUOTAS COMPENSATORIAS, GRAVAMENES Y DERECHOS.
- Clave de contribucion.-CONTRIBUCIONES, CUOTAS COMPENSATORIAS, GRAVAMENES Y DERECHOS.
- Clave forma de pago.
- Importe de pago
- Clave de unidad de medida: UNIDADES, CONTENDORES, TONELADAS, PAQUETES, ETC.
- Cantidad de mercancía descrgada.
- Clave del país del domicilio destinatario.
- Descripción de la mercancia
- Precio unitario
- Valor en aduana
- Valor comercial.- En mn. sin incluir fletes, seguros ni otros conceptos.
- Cantidad de mercancias en unidades de medida comercial.
- Código de la mercancía o producto.
- Marca de la mercancía o producto.
- Fracción arancelaria.

Codificación:

Se adjunta en l carpeta de anexos los archivos necesarios para la decodificación de toda la información.
Estos corresponden a los anexos correspondientes de cada sección















