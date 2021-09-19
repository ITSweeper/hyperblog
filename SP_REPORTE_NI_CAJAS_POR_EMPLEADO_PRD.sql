USE [SAV_SINDICALIZADO]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTE_NI_CAJAS_POR_EMPLEADO]    Script Date: 06/14/2017 11:33:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*           
-------------------------------------------------------------------------------------------------------                 
Autor: Schunk Gastón C.    
              
Descripción: Devuelve las cajas vendidas por usuario    
              
Parámetros:              
 @SOCIEDAD     Sociedad para la que se va a obtener el reporte    
 @DIV_PERSONAL  División de personal  para la que se va a obtener el reporte    
 @EJERCICIO  Número de Ejercicio    
 @PERIODO  Número del Período    
 @TIPO_LIQUIDACION Tipo de liquidacion     
 @LEGAJO   Legajo del Empleado divididos por |    
 @IDIOMA   Idioma    
-------------------------------------------------------------------------------------------------------              
Modificación:    
 09/May/2011, CVP - Carlos Vara    
  Éste procedimiento es una copia del procedimiento SP_REPORTE_GT_CAJAS_POR_EMPLEADO    
  la diferencia consiste en que esta adecuado para Nicaragua utilizando la tabla TL_FACTORES_COMISION    
  y una tabla temporal para agrupar los productos de forma distinta a los Items de Interface.    
  Utiliza la tabla TL_HISTORIA_VENTA y TL_HISTORIA_PREVENTA.    
 06/Sep/2011, MRS - Mayda Rodriguez    
  Se hacen modificaciones a la consulta para considerar casos especiales de preventa tales como estar en     
  mas de una ruta, casos de suplencias, y casos de ausentismos.    
    20/Jun/2012, MRS - Mayda Rodriguez    
  Se agregan dos productos a la tabla de categorias    
    09/Ju1/2012, MRS - Mayda Rodriguez    
  Se agregan la categoria Energeticos    
    09/Ju1/2012, MRS - Mayda Rodriguez    
  Se agregan cuatro productos a la tablas de categorias    
    25/Oct/2012, MRS - Mayda Rodriguez    
  Se agregan cuatro productos a la tablas de categorias    
 07/Feb/2013, AFV - Alberto Flores Vasquez    
  Se agrega un producto a la tabla de categorías.    
    26/Abr/2013, MRS / Mayda Rodriguez    
  Se agregan tres productos a la tabla de categorias    
 20/May/2013, AFV - Alberto Flores Vasquez    
  Se agregan dos productos nuevos a la tabla de categorias.     
 23/May/2013, MRS - Mayda Rodriguez    
  Se agrega un producto nuevo a la tabla de categorias.     
 17/Jul/2013, AFV - Alberto Flores Vasquez    
  Se agregan dos productos nuevos a la tabla de categorias.     
 06/Sep/2013, AFV - Alberto Flores Vasquez    
  Se agrega un producto nuevo a la tabla de categorias.     
 16/Oct/2013, AFV - Alberto Flores Vasquez    
  Se agregan cinco productos a la tabla de categorias.     
    04/Nov/2013, MRS - Mayda Rodriguez    
  Se agregan tres productos a la tablas de categorias     
 04/Feb/2014, AFV - Alberto Flores    
  Se agregan dos productos a la tablas de categorias     
 13/Feb/2014, AFV - Alberto Flores Vasquez    
  Se agregan 2 SKU a las categorías.    
 19/Feb/2014, AFV - Alberto Flores Vasquez    
  Se elimina 1 SKU de las categorías debido a duplicidad.    
 20/Feb/2014, AFV - Alberto Flores Vasquez    
  Se agregan 2 SKU a las categorías.    
 28/Feb/2014, AFV - Alberto Flores Vasquez    
  Se agrega 1 SKU a las categorías.    
 18/Mar/2014, AFV - Alberto Flores Vasquez    
  Se agrega 1 SKU a las categorías.    
 19/Mar/2014, AFV - Alberto Flores Vasquez    
  Se agrega 1 SKU a las categorías.    
 10/Abr/2014, AFV - Alberto Flores Vasquez    
  Se agrega un metodo para obtener la funcion de la tripulacion por dia.    
 15/Abr/2014, AFV - Alberto Flores Vasquez    
  Se complementa la tabla temporal de salida proceso para que genere un registro por cada item de interface y función trabajada para que concida con el metodo implementado el 10.04.2014    
 24/Abr/2014, AFV - Alberto Flores Vasquez    
  Se adecua la manera de obtener la función de la tirpulación por día segun conceptos de cajas por factor en NI.    
 25/Jun/2014, AFV - Alberto Flores Vasquez    
  Se agrega 1 SKU a las categorías.    
 19/Ago/2014, RGV - Rousbelt Garza Villarreal    
  Se agrega 1 SKU a las categorías.    
 05/Sep/2014, RGV - Rousbelt Garza Villarreal    
  Se agregan 4 SKU a las categorías.    
 31/Oct/2014, RGV - Rousbelt Garza Villarreal    
  Se agregan 1 SKU a las categorías.      
 19/Noviembre/2014, AFV - Alberto Flores Vasquez    
  Se agregan 1 SKU a las categorías.    
 24/Febrero/2015, MRS - Mayda Rodriguez Serrato    
  Se agregan 3 SKU a las categorías.      
 09/Marzo/2015, AFV - Alberto Flores Vasquez    
  Se agregan 1 SKU a las categorías.    
 13/Mayo/2015, AFV - Alberto Flores Vasquez    
  Se agregan 1 SKU a las categorías.    
 02/Junio/2015, AFV - Alberto Flores Vasquez    
  Se agregan 1 SKU a las categorías.    
 10/Julio/2015, AFV - Alberto Flores Vasquez    
  Se agregan 1 SKU a las categorías.  
 31/Julio/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.  
 13/Agosto/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.  
 25/Agosto/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.  
 25/Septiembre/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 4 SKU a las categorías.  
 12/Octubre/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.  
 23/Octubre/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 3 SKU a las categorías.    
 30/Octubre/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.    
 20/Noviembre/2015, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.   
 10/Marzo/2015, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.   
 31/Marzo/2015, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.   
 05/Abril/2015, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.   
 31/Mayo/2016, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.   
 27/Julio/2016, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.   
 29/Julio/2016, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.   
 12/Septiembre/2016, AFV - Alberto Flores Vasquez  
  Se agregan 2 SKU a las categorías.   
 19/Septiembre/2016, AFV - Alberto Flores Vasquez  
  Se agregan 1 SKU a las categorías.  
 25/Octubre/2016, RGV - Rousbelt Garza Villarreal  
  Se agregan 2 SKU a las categorías.
 11/NOVIEMBRE/2016, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.
 23/ENERO/2017, RGV - Rousbelt Garza Villarreal  
  Se agregan 1 SKU a las categorías.
 08/FEBRERO/2017, AGC - Alejandro García Cantú  
  Se agregan 1 SKU a las categorías.
------------------------------------------------------------------------------------------------------                       
*/    
ALTER PROCEDURE [dbo].[SP_REPORTE_NI_CAJAS_POR_EMPLEADO](    
--DECLARE     
 @SOCIEDAD UDT_SAVSOCIEDAD,     
 @DIV_PERSONAL UDT_SAVDIV_PERSONAL,     
 @EJERCICIO NUMERIC(18, 0),     
 @PERIODO          INT,     
 @TIPO_LIQUIDACION VARCHAR(2),     
 @LEGAJO VARCHAR(8000),     
 @IDIOMA          CHAR (1)    
) AS     
    
SET NOCOUNT ON     
/*    
SELECT @SOCIEDAD = 'F445'     
SELECT @DIV_PERSONAL = '0376'     
SELECT @EJERCICIO = 2011     
SELECT @PERIODO = 9     
SELECT @TIPO_LIQUIDACION = '03'     
SELECT @LEGAJO = '|1544387|' --'|1329716|' -- =     
SELECT @IDIOMA ='S'     
*/    
    
DECLARE @FECHA_DESDE DATETIME,     
  @FECHA_HASTA DATETIME,     
  @TIPO_SALIDA CHAR(1),    
  @FECHA_DESDE_AUX DATETIME     
    
SELECT @TIPO_SALIDA = 'P'     
    
--------------------------------------------------------     
------------ Busco las fechas del Periodo ----------------     
--------------------------------------------------------     
SELECT     
 @FECHA_DESDE = FECHA_DESDE,     
  @FECHA_HASTA = FECHA_HASTA,    
 @FECHA_DESDE_AUX = FECHA_DESDE    
FROM   TL_PERIODO_LIQUIDACION_DETALLE PL WITH (NOLOCK)     
INNER JOIN TL_SOCIEDADES S WITH (NOLOCK)     
 ON S.SOCIEDAD = @SOCIEDAD     
 AND S.TIPO_ACUMULACION = PL.TIPO_ACUMULACION     
WHERE TIPO_LIQUIDACION = @TIPO_LIQUIDACION     
 AND EJERCICIO = @EJERCICIO     
 AND PERIODO = @PERIODO     
    
    
    
    
    
-- se crea la tabla temporal      
CREATE TABLE #FECHAS(      
    FEC  DATETIME      
)      
      
CREATE TABLE #EMPLEADO(      
  EMPLEADO NUMERIC(8,0),      
  TIPO_RUTA VARCHAR(10),         
  RUTA  VARCHAR(10),     
  FECHA  DATETIME,     
  FECHA_PVTA DATETIME,     
  TIPO_VENTA  CHAR(1),      
  TIPO  CHAR(2),    
  FUNCION INT  --AFV 10.04.2014 Se agrega el valor de función.    
)      
      
      
-- se insertan en la tabla temporal todas las fechas entre       
WHILE  ( @FECHA_DESDE_AUX <= @FECHA_HASTA)      
    BEGIN      
  INSERT INTO #FECHAS(FEC) VALUES (@FECHA_DESDE_AUX)       
  SET @FECHA_DESDE_AUX =  DATEADD(DAY, 1, @FECHA_DESDE_AUX)      
    END       
      
      
INSERT INTO #EMPLEADO      
 SELECT DISTINCT R.LEGAJO_R,       
    R.TIPO_RUTA, -- 09/Jul/2009, GL      
    R.RUTA,       
    R.FECHA,      
    NULL, -- 09/Jul/2009, GL       
    'R' ,    
    'R',-- 09/Jul/2009, GL   ,    
    E.FUNCION --AFV 24.04.2014 Se recupera el valor de la funcion del empleado    
  FROM  dbo.TL_TRIPULACION_REAL_SAT R WITH (NOLOCK)      
 INNER JOIN TL_EMPLEADOS E WITH (NOLOCK)       --AFV 24.04.2014 INICIO    
  ON E.SOCIEDAD = R.SOCIEDAD    
  AND E.DIV_PERSONAL = R.DIV_PERSONAL    
  AND E.LEGAJO = R.LEGAJO_R    
  AND R.FECHA BETWEEN E.VIG_DESDE AND E.VIG_HASTA    --AFV 24.04.2014 FIN    
  WHERE  R.SOCIEDAD  = @SOCIEDAD      
     AND  R.DIV_PERSONAL  = @DIV_PERSONAL      
     AND  R.LEGAJO_R  NOT IN (0,99999999)      
     AND R.FECHA  BETWEEN @FECHA_DESDE AND @FECHA_HASTA      
 UNION       
 SELECT DISTINCT R.LEGAJO_A,       
    R.TIPO_RUTA,  -- 09/Jul/2009, GL        
    R.RUTA,       
    R.FECHA,      
    NULL, -- 09/Jul/2009, GL       
    'R' ,-- 09/Jul/2009, GL       
    'A',    
  E.FUNCION --AFV 24.04.2014 Se recupera el valor de la funcion del empleado.    
  FROM  dbo.TL_TRIPULACION_REAL_SAT R WITH (NOLOCK)      
 INNER JOIN TL_EMPLEADOS E WITH (NOLOCK)       --AFV 24.04.2014 INICIO    
  ON E.SOCIEDAD = R.SOCIEDAD    
  AND E.DIV_PERSONAL = R.DIV_PERSONAL    
  AND E.LEGAJO = R.LEGAJO_A    
  AND R.FECHA BETWEEN E.VIG_DESDE AND E.VIG_HASTA    --AFV 24.04.2014 FIN    
        WHERE  R.SOCIEDAD  = @SOCIEDAD      
       AND  R.DIV_PERSONAL  = @DIV_PERSONAL      
       AND  R.LEGAJO_A  NOT IN (0,99999999)      
       AND R.FECHA  BETWEEN @FECHA_DESDE AND @FECHA_HASTA      
 UNION       
 SELECT DISTINCT R.LEGAJO_AS,       
    R.TIPO_RUTA,  -- 09/Jul/2009, GL        
    R.RUTA,       
    R.FECHA,      
    NULL, -- 09/Jul/2009, GL       
    'R' ,-- 09/Jul/2009, GL       
    'AS',    
  E.FUNCION --AFV 24.04.2014 Se recupera el valor de la función del empleado.    
  FROM  dbo.TL_TRIPULACION_REAL_SAT R WITH (NOLOCK)      
 INNER JOIN TL_EMPLEADOS E WITH (NOLOCK)       --AFV 24.04.2014 INICIO    
  ON E.SOCIEDAD = R.SOCIEDAD    
  AND E.DIV_PERSONAL = R.DIV_PERSONAL    
  AND E.LEGAJO = R.LEGAJO_AS    
  AND R.FECHA BETWEEN E.VIG_DESDE AND E.VIG_HASTA    --AFV 24.04.2014 FIN    
        WHERE  R.SOCIEDAD  = @SOCIEDAD      
       AND  R.DIV_PERSONAL  = @DIV_PERSONAL      
       AND  R.LEGAJO_AS  NOT IN (0,99999999)      
       AND R.FECHA  BETWEEN @FECHA_DESDE AND @FECHA_HASTA      
 -- MERS 24JUN2009 Desde        
 UNION        
 SELECT DISTINCT R.LEGAJO,       
    R.TIPO_RUTA,  -- 09/Jul/2009, GL      
    R.RUTA,       
    FECHA ,      
    NULL, -- 09/Jul/2009, GL       
    'R', -- 09/Jul/2009, GL       
    'AS',    
  E.FUNCION --AFV 24.04.2014 Se recupera el valor de la función del empleado.    
  FROM  dbo.TL_AUXILIARES_SAT R WITH (NOLOCK)      
     INNER JOIN TL_EMPLEADOS E WITH (NOLOCK)       --AFV 24.04.2014 INICIO    
  ON E.SOCIEDAD = R.SOCIEDAD    
  AND E.DIV_PERSONAL = R.DIV_PERSONAL    
  AND E.LEGAJO = R.LEGAJO    
  AND R.FECHA BETWEEN E.VIG_DESDE AND E.VIG_HASTA     --AFV 24.04.2014 FIN    
     WHERE R.SOCIEDAD = @SOCIEDAD        
       AND  R.DIV_PERSONAL = @DIV_PERSONAL        
       AND   R.FECHA  BETWEEN @FECHA_DESDE AND @FECHA_HASTA        
     -- MERS 24JUN2009 Hasta        
      
      
      
      
-- 09/Jul/2009, GL  Desde       
      
-- BORRA LAS RUTAS DE PREVENTA QUE SERµN TRATAS POR SEPARADO      
    DELETE EMP  FROM  #EMPLEADO EMP      
      INNER JOIN TL_TIPO_RUTAS AS TTR WITH (NOLOCK)      
      ON TTR.TIPO_RUTA = EMP.TIPO_RUTA       
     AND TTR.TIPO_AGRUP = '04'      
      
      
-- Agregado para incorporar la preventa, considerando que el trabajador haya estado en la tripulaci¢n el d¡a que se realiz¢ la venta..      
INSERT INTO #EMPLEADO      
    SELECT  DISTINCT       
   R.LEGAJO_R,       
       R.TIPO_RUTA,      
       R.RUTA,       
       P.FECHA_INTERFASE,      
       P.FECHA,      
       'P' , 'R',    
       E.FUNCION --AFV 24.04.2014 Se recupera el valor de la función del empleado.    
    FROM   TL_TRIPULACION_REAL_SAT R WITH (NOLOCK)      
 INNER JOIN TL_TIPO_RUTAS AS TTR WITH (NOLOCK)            
    ON TTR.TIPO_RUTA = R.TIPO_RUTA       
     AND TTR.TIPO_AGRUP = '04'      
 INNER JOIN TL_HISTORIA_PREVENTA P WITH (NOLOCK)      
    ON  P.RUTA   = R.RUTA      
     AND  P.FECHA    = R.FECHA      
     AND  P.SOCIEDAD   = R.SOCIEDAD      
     AND  P.DIV_PERSONAL  = R.DIV_PERSONAL      
     AND P.FECHA_INTERFASE  BETWEEN  @FECHA_DESDE AND @FECHA_HASTA      
 INNER JOIN TL_EMPLEADOS E WITH (NOLOCK)          --AFV 24.04.2014 INICIO    
  ON E.SOCIEDAD = R.SOCIEDAD    
  AND E.DIV_PERSONAL = R.DIV_PERSONAL    
  AND E.LEGAJO = R.LEGAJO_R    
  AND R.FECHA BETWEEN E.VIG_DESDE AND E.VIG_HASTA       --AFV 24.04.2014 FIN    
    WHERE  R.SOCIEDAD   = @SOCIEDAD      
     AND   R.DIV_PERSONAL  = @DIV_PERSONAL      
     AND   R.LEGAJO_R  NOT IN (0,99999999)      
      
    
      
    
    
    
    
    
--CVP 05May2011 -- Se crea Tabla Temporal para relacionar los items de interface (presentaciones) con los grupos     
--que Nicaragua requiere.     
CREATE TABLE #TMPGRUPOS     
(     
 PRODUCTO INT,     
 GRUPO    VARCHAR(50)     
)     
    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4038,'AGUA')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5503,'AGUA')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7024,'AGUA')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7272,'AGUA')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (128,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (148,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (169,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (170,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (190,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1990,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2241,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2242,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2400,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (270,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4087,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4150,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4176,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4337,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4380,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4436,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4437,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4677,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4968,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4984,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5037,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5269,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5275,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5278,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5313,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5468,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5675,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5676,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5678,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6213,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6349,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6412,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (650,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6591,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6601,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6613,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6761,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6779,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6795,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6852,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6956,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7110,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7711,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7713,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7714,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7725,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7750,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7754,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7777,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7778,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7788,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7789,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7790,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7791,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7793,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7796,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7798,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7961,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7968,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7969,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8415,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8416,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8417,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8418,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8422,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8423,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2438,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4724,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4934,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4935,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4948,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4950,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6837,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7964,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8070,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4469,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4603,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4618,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4619,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4753,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5074,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5075,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6523,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6818,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7547,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7718,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7719,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7722,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7723,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7832,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4534,'TE')    
-- PRODUCTOS NUEVOS MRS 16JUN2011    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4520,'TE')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4530,'TE')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5059,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6810,'MIXTO')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6813,'MIXTO')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8049,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8080,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8171,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8172,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8173,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8176,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8178,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8179,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8364,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (9999,'CSD')    
-- PRODUCTOS NUEVOS MRS 22JUN2011    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8413,'CSD')    
-- PRODUCTOS NUEVOS MRS 06SEP2011    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7225,'MIXTO')     
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7592,'ISOTONICOS')     
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7949,'ISOTONICOS')     
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8333,'CSD')     
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8336,'JUGOS')     
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8414,'CSD')    
-- PRODUCTOS NUEVOS MRS 01NOV2011    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4338,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7971,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7972,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1385,'MIXTO')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7948,'MIXTO')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4467,'TE')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1360,'AGUA')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4978,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1397,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4572,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4933,'JUGOS')    
-- PRODUCTOS NUEVOS MRS 06MAR2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5677,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7970,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7668,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2304,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7882,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7933,'JUGOS')    
-- PRODUCTOS NUEVOS MRS 20MAR2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1804,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2629,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7669,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1792,'CSD')    
-- PRODUCTOS NUEVOS MRS 20JUN2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2627,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8064,'CSD')    
-- NUEVA CATEGORIA MRS 09JUL2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2312,'ENERGETICO')    
-- PRODUCTOS NUEVOS MRS 19JUL2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (991,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (993,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1299,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1340,'JUGOS')    
-- PRODUCTOS NUEVOS CVP 30JUL2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2205,'CSD')    
-- PRODUCTOS NUEVOS MRS 25OCT2012    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2050,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7334,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (6963,'ISOTONICOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1940,'TE')    
-- PRODUCTOS NUEVOS CVP 17ENE2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (3024,'CSD')    
-- PRODUCTOS NUEVOS AFV 07FEB2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2370,'JUGOS')    
-- PRODUCTOS NUEVOS MRS 26ABR2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2182,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (2257,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8282,'CSD')    
-- PRODUCTOS NUEVOS AFV 20MAY2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8491,'TE')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8492,'TE')    
-- PRODUCTOS NUEVOS MRS 23MAY2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (3037,'ISOTONICOS')    
-- PRODUCTOS NUEVOS AFV 17JUL2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5039,'JUGOS')    
-- PRODUCTOS NUEVOS AFV 06SEP2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5506,'JUGOS')    
-- PRODUCTOS NUEVOS AFV 16OCT2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7682,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7937,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8095,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8097,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8278,'CSD')    
-- PRODUCTOS NUEVOS MRS 04NOV2013    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8440,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8434,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (5507,'TE')    
-- PRODUCTOS NUEVOS AFV 04FEB2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4626,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (8002,'CSD')    
-- PRODUCTOS NUEVOS AFV 13FEB2014    
--INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3024,'CSD') RELACION DUPLICADA AFV 19FEB2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(8379,'CSD')    
-- PRODUCTOS NUEVOS AFV 20FEB2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4528,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (4532,'JUGOS')    
-- PRODUCTOS NUEVOS AFV 28FEB2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(7188,'CSD')    
-- PRODUCTOS NUEVOS AFV 18MAR2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(4465,'CSD')    
-- PRODUCTOS NUEVOS AFV 19MAR2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(2157,'CSD')    
-- PRODUCTOS NUEVOS AFV 25JUN2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(8496,'CSD')    
-- PRODUCTOS NUEVOS RGV 19AGO2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(7184,'CSD')    
-- PRODUCTOS NUEVOS RGV 05SEP2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3040,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(8494,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(801505,'CSD')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(801509,'CSD')    
-- PRODUCTOS NUEVOS RGV 31OCT2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1505,'CSD')    
-- PRODUCTOS NUEVOS AFV 19NOV2014    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1509,'CSD')    
-- PRODUCTOS NUEVOS MRS 04FEB2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7202,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7205,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (7207,'JUGOS')      
-- PRODUCTOS NUEVOS AFV 09MAR2015    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1551,'CSD')    
-- PRODUCTOS NUEVOS AFV 13MAY2015    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1558,'AGUA')  
-- PRODUCTOS NUEVOS AFV 02JUN2015    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1561,'ISOTONICOS')      
-- PRODUCTOS NUEVOS AFV 10JUL2015    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1570,'ISOTONICOS')  
-- PRODUCTOS NUEVOS RGV 31JUL2015    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1573,'CSD')   
-- PRODUCTOS NUEVOS RGV 13AGO2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1575,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1576,'CSD')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1577,'CSD')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1578,'CSD')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1579,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1580,'CSD')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1581,'CSD')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1582,'TE')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1583,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1584,'ISOTONICOS')  
-- PRODUCTOS NUEVOS RGV 25AGO2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1589,'TE')  
-- PRODUCTOS NUEVOS RGV 25SEP2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1523,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1524,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1553,'JUGOS')    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1597,'JUGOS')  
-- PRODUCTOS NUEVOS RGV 12OCT2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1574,'JUGOS')  
-- PRODUCTOS NUEVOS RGV 23OCT2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1610,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1611,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1609,'CSD')  
-- PRODUCTOS NUEVOS RGV 31OCT2015  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1614,'TE')  
-- PRODUCTOS NUEVOS RGV 20NOV2015    
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1617,'MIXTO')  
-- PRODUCTOS NUEVOS AFV 10MAR2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (1545,'JUGOS')  
-- PRODUCTOS NUEVOS AFV 31MAR2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES (3328,'ISOTONICOS')  
-- PRODUCTOS NUEVOS AFV 05ABR2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3228,'CSD')  
-- PRODUCTOS NUEVOS AFV 31MAY2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3230,'MIXTO')  
-- PRODUCTOS NUEVOS AFV 27JUL2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3250,'ISOTONICOS')  
-- PRODUCTOS NUEVOS AFV 29JUL2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3256,'ISOTONICOS')  
-- PRODUCTOS NUEVOS AFV 12SEP2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(7883,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(1569,'JUGOS')  
-- PRODUCTOS NUEVOS AFV 12SEP2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3258,'ISOTONICOS')  
-- PRODUCTOS NUEVOS RDG 25OCT2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3272,'JUGOS')  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3273,'CSD')  
-- PRODUCTOS NUEVOS RDG 11NOV2016  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3277,'CSD')
-- PRODUCTOS NUEVOS RDG 23ENE2017  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3286,'CSD')     
-- PRODUCTOS NUEVOS JAG 08FEB2017  
INSERT INTO #tmpGrupos (PRODUCTO, GRUPO) VALUES(3291,'MIXTO')                  
 
 
SELECT     
 TSP.SOCIEDAD,     
 TSP.DIV_PERSONAL,     
 TSP.LEGAJO,     
 TII.ITEM_INTERFASE,     
 TII.DESCRIPCION,     
 TSP.RUTA,     
 R.TIPO_RUTA,     
 TTF.TIPO_FACTOR,     
 --TSP.FUNCION,    --AFV 15.04.2014    
 E.FUNCION,     --AFV 15.04.2014 Se obtiene la función de la tabla temporal de tripulacion #EMPLEADO    
 ISNULL(TRS.LETRA_FUNCION, 'NA') AS TIPO     
INTO #T_SALIDA_PROCESO     
FROM TL_SALIDA_PROCESO TSP WITH (NOLOCK)     
INNER JOIN TL_CONCEPTOS TC WITH (NOLOCK)     
 ON TC.DIV_PERSONAL = TSP.DIV_PERSONAL     
 AND TC.SOCIEDAD = TSP.SOCIEDAD     
 AND TC.CONCEPTO = TSP.CONCEPTO     
INNER JOIN TL_TIPO_FACTORES TTF WITH (NOLOCK)     
 ON TTF.SOCIEDAD = TC.SOCIEDAD     
 AND TTF.DIV_PERSONAL = TC.DIV_PERSONAL     
 AND CHARINDEX('|' + CONVERT(VARCHAR(2), TTF.TIPO_FACTOR) + '|',     
   TC.FORMULA) > 0     
INNER JOIN TL_ITEMS_INTERFASE TII WITH (NOLOCK)     
 ON TTF.SOCIEDAD = TII.SOCIEDAD     
 AND TTF.DIV_PERSONAL = TII.DIV_PERSONAL     
 AND TTF.ITEM_INTERFASE = TII.ITEM_INTERFASE     
INNER JOIN DBO.TL_RUTAS R WITH (NOLOCK)     
 ON R.SOCIEDAD = TSP.SOCIEDAD     
 AND R.DIV_PERSONAL = TSP.DIV_PERSONAL     
 AND R.RUTA = TSP.RUTA     
INNER JOIN #EMPLEADO E WITH (NOLOCK)      --AFV 15.04.2014 INICIO    
 ON E.EMPLEADO = TSP.LEGAJO    
 AND E.RUTA = R.RUTA    
 AND E.TIPO_RUTA = R.TIPO_RUTA    
 AND E.FECHA BETWEEN @FECHA_DESDE AND @FECHA_HASTA  --AFV 15.04.2014 FIN    
     
LEFT JOIN (SELECT TRS1.SOCIEDAD,     
                   TRS1.DIV_PERSONAL,     
                   TRS1.RUTA,     
                   TRS1.FECHA,     
                   TRS1.LEGAJO_R LEGAJO,     
                   'R'           LETRA_FUNCION     
            FROM   TL_TRIPULACION_REAL_SAT TRS1 WITH (NOLOCK)     
            WHERE  TRS1.SOCIEDAD = @SOCIEDAD     
                   AND TRS1.DIV_PERSONAL = @DIV_PERSONAL     
                   AND TRS1.FECHA BETWEEN @FECHA_DESDE AND @FECHA_HASTA     
            UNION     
            SELECT TRS2.SOCIEDAD,     
                   TRS2.DIV_PERSONAL,     
                   TRS2.RUTA,     
                   TRS2.FECHA,     
                 TRS2.LEGAJO_A LEGAJO,     
                   'A'           LETRA_FUNCION     
            FROM   TL_TRIPULACION_REAL_SAT TRS2 WITH (NOLOCK)     
            WHERE  TRS2.SOCIEDAD = @SOCIEDAD     
                   AND TRS2.DIV_PERSONAL = @DIV_PERSONAL     
                   AND TRS2.FECHA BETWEEN @FECHA_DESDE AND @FECHA_HASTA     
            UNION     
            SELECT TRS3.SOCIEDAD,     
                   TRS3.DIV_PERSONAL,     
                   TRS3.RUTA,     
                   TRS3.FECHA,     
                   TRS3.LEGAJO_AS LEGAJO,     
                   'AS'           LETRA_FUNCION     
            FROM   TL_TRIPULACION_REAL_SAT TRS3 WITH (NOLOCK)     
            WHERE  TRS3.SOCIEDAD = @SOCIEDAD     
                   AND TRS3.DIV_PERSONAL = @DIV_PERSONAL     
                   AND TRS3.FECHA BETWEEN @FECHA_DESDE AND @FECHA_HASTA     
            UNION     
            SELECT TRS4.SOCIEDAD,     
                   TRS4.DIV_PERSONAL,     
                   TRS4.RUTA,     
                   TRS4.FECHA,     
                   TRS4.LEGAJO LEGAJO,     
                   'AS'        LETRA_FUNCION     
            FROM   TL_AUXILIARES_SAT AS TRS4 WITH (NOLOCK)     
            WHERE  TRS4.SOCIEDAD = @SOCIEDAD     
                   AND TRS4.DIV_PERSONAL = @DIV_PERSONAL     
                   AND TRS4.FECHA BETWEEN @FECHA_DESDE AND @FECHA_HASTA)     
           TRS     
   ON TSP.LEGAJO = TRS.LEGAJO     
    AND TSP.RUTA = TRS.RUTA    
-- AND TII.PREVENTA = 1     
WHERE TSP.SOCIEDAD = @SOCIEDAD     
 AND TSP.DIV_PERSONAL = @DIV_PERSONAL     
 AND TSP.EJERCICIO = @EJERCICIO     
 AND TSP.PERIODO = @PERIODO     
 AND ( CHARINDEX('|' + CONVERT(VARCHAR(12), TSP.LEGAJO) + '|', @LEGAJO) > 0 OR @LEGAJO = '-1' )     
 AND TSP.TIPO_SALIDA = @TIPO_SALIDA     
 -- AND (CHARINDEX('|' + CONVERT(VARCHAR(2),TII.ITEM_INTERFASE) + '|', @ITEM_INTERFASE )>0 OR @ITEM_INTERFASE = '-1' )     
GROUP BY TSP.SOCIEDAD,     
 TSP.DIV_PERSONAL,     
 TSP.LEGAJO,     
 TSP.RUTA,     
 --TSP.FUNCION     --AFV 15.04.2014    
 E.FUNCION,      --AFV 15.04.2014 Se agrupa por la función de la tabla temporal de tripulacion #EMPLEADO    
 R.TIPO_RUTA,     
 TTF.TIPO_FACTOR,     
 TII.ITEM_INTERFASE,     
 TII.DESCRIPCION,     
 TRS.LETRA_FUNCION     
    
CREATE INDEX T_SALIDAPROCESO     
 ON #T_SALIDA_PROCESO(SOCIEDAD, DIV_PERSONAL, LEGAJO)     
    
-- select * from #T_SALIDA_PROCESO     
SELECT GPO.GRUPO AS DESCRIPCION,     
 0 AS ITEM_INTERFASE,     
 CONVERT(VARCHAR(12), HIST.FECHAPAGO, 103) AS FECHA,     
 SUM(HIST.CAJAS)            AS CAJAS,     
 SUM(FC.VALOR * HIST.CAJAS) AS MONTO,     
 SUM(HIST.CAJAS)            AS CAJAS_PAGO,     
 0                          AS IMPORTE_INCREMENTO,     
 TSP.LEGAJO,     
 TSP.RUTA,     
 TSP.TIPO,     
 HIST.TIPO    
FROM   #T_SALIDA_PROCESO TSP WITH (NOLOCK)     
 INNER JOIN (SELECT  V.SOCIEDAD,       
    V.DIV_PERSONAL,       
    V.FECHA FECHAVENTA,       
    V.FECHA FECHAPAGO,       
    V.ITEM_INTERFASE,       
    V.PRODUCTO,       
    V.CAJAS * ISNULL(G.FACTOR_CONVERSION, 1.0)  CAJAS,       
    V.RUTA,    
    E.EMPLEADO                      LEGAJO,    
    E.TIPO  ,    
    E.FUNCION   --AFV 10.04.2014 Se recupera la función.    
     FROM   #EMPLEADO E       
       LEFT JOIN ( TL_HISTORIA_VENTA V WITH (NOLOCK)      
  LEFT JOIN dbo.VW_PRODUCTOS_FACTOR G WITH (NOLOCK)      
   ON G.SOCIEDAD   = V.SOCIEDAD           
   AND G.DIV_PERSONAL  = V.DIV_PERSONAL        
   AND G.PRODUCTO   = V.PRODUCTO                
   AND  G.UN_NEG   = V.UN_NEG  )      
        ON  V.RUTA   = E.RUTA      
        AND  V.FECHA   = E.FECHA      
        AND V.SOCIEDAD   = @SOCIEDAD      
        AND  V.DIV_PERSONAL  = @DIV_PERSONAL      
        AND V.FECHA BETWEEN  @FECHA_DESDE AND @FECHA_HASTA        
        AND E.TIPO_VENTA = 'R'      
        -- 09/Jul/2009, GL  Desde      
     UNION ALL    
  SELECT  P.SOCIEDAD,       
    P.DIV_PERSONAL,       
    P.FECHA FECHAVENTA,       
    P.FECHA_INTERFASE FECHAPAGO,       
    P.ITEM_INTERFASE,       
    P.PRODUCTO,       
    P.CAJAS * ISNULL(F.FACTOR_CONVERSION, 1.0)  CAJAS,       
    --TR.RUTA,    
    ISNULL(TR.RUTA,E.RUTA),    
    E.EMPLEADO                      LEGAJO,    
    E.TIPO ,    
    E.FUNCION     
  FROM   #EMPLEADO E       
    LEFT JOIN TL_TRIPULACION_REAL_SAT TR -- MRS 06 SEP 2011  Para imprimir en el reporte la ruta en la que estuvo en tripulacion, cuando hay mas de una ruta.    
   ON  TR.SOCIEDAD  = @SOCIEDAD        
      AND  TR.DIV_PERSONAL  = @DIV_PERSONAL        
      AND  TR.LEGAJO_R  =  E.EMPLEADO      
      AND TR.FECHA  = E.FECHA       
    LEFT JOIN (  TL_HISTORIA_PREVENTA P WITH (NOLOCK)      
      LEFT JOIN dbo.VW_PRODUCTOS_FACTOR F WITH (NOLOCK)      
       ON F.SOCIEDAD   = P.SOCIEDAD           
       AND F.DIV_PERSONAL  = P.DIV_PERSONAL        
       AND F.PRODUCTO   = P.PRODUCTO                
       AND  F.UN_NEG   = P.UN_NEG        
      )      
     ON  P.RUTA   = E.RUTA      
     AND  P.FECHA_INTERFASE  = E.FECHA -- FECHA EN QUE SE INFORMA LA VENTA EN LA INTERFASE (ES LA FECHA DE COBRO)      
     AND  P.FECHA   = E.FECHA_PVTA -- FECHA EN LA QUE SE REALIZA LA VENTA      
     AND  P.SOCIEDAD   = @SOCIEDAD      
     AND  P.DIV_PERSONAL  = @DIV_PERSONAL      
     AND P.FECHA_INTERFASE  BETWEEN  @FECHA_DESDE AND @FECHA_HASTA      
     AND E.TIPO_VENTA = 'P' )HIST     
   ON TSP.DIV_PERSONAL = HIST.DIV_PERSONAL     
      AND TSP.SOCIEDAD = HIST.SOCIEDAD     
      AND TSP.LEGAJO = HIST.LEGAJO     
      AND TSP.RUTA = HIST.RUTA    
      AND HIST.ITEM_INTERFASE = TSP.ITEM_INTERFASE     
      AND HIST.TIPO = TSP.TIPO    
      AND TSP.FUNCION = HIST.FUNCION   --AFV 10.04.2014 Se filtra por funcion para evitar que cuando un empleado tuvo dos funciones en un periodo se dupliquen las cajas.    
 INNER JOIN TL_EMPLEADOS TE WITH (NOLOCK)     
   ON HIST.LEGAJO = TE.LEGAJO     
      AND TE.SOCIEDAD = TSP.SOCIEDAD     
      AND TE.DIV_PERSONAL = TSP.DIV_PERSONAL     
      AND @FECHA_HASTA BETWEEN TE.VIG_DESDE AND TE.VIG_HASTA     
 --------------------------------------------------------------------------------------------     
 INNER JOIN TL_FACTORES_COMISION AS FC WITH (NOLOCK)     
   ON FC.SOCIEDAD = TSP.SOCIEDAD     
      AND FC.DIV_PERSONAL = TSP.DIV_PERSONAL     
      AND FC.TIPO_RUTA = TSP.TIPO_RUTA     
      AND FC.TIPO_FACTOR = TSP.TIPO_FACTOR     
      AND FC.FUNCION = TSP.FUNCION     
      AND HIST.FECHAVENTA BETWEEN FC.VIG_DESDE AND FC.VIG_HASTA     
 ------------------------------------------------------------------------------------------------     
 INNER JOIN #TMPGRUPOS GPO     
   ON HIST.PRODUCTO = GPO.PRODUCTO     
--------------------------------------------------------------------------------------------     
GROUP  BY GPO.GRUPO,     
    HIST.FECHAPAGO,     
    TSP.LEGAJO,     
    TSP.RUTA,     
    TSP.TIPO,    
    HIST.TIPO    
    
-- MRS 06 SEP 2011 AGREGAR LA COMISION PAGADA POR SUPLENCIAS    
--------------------------------------------------------------------------------------------     
UNION ALL    
     SELECT TC.DESCRIPCION,     
 0 AS ITEM_INTERFASE,     
 CONVERT(VARCHAR(12), @FECHA_HASTA, 103) AS FECHA,     
 0           AS CAJAS,     
 SUM(TSP.VALOR)AS MONTO,     
 0  AS CAJAS_PAGO,     
 0                          AS IMPORTE_INCREMENTO,     
 TSP.LEGAJO,     
 '--',     
 'NA',     
 'NA'    
    FROM TL_SALIDA_PROCESO TSP WITH (NOLOCK)     
    INNER JOIN TL_CONCEPTOS TC WITH (NOLOCK)     
     ON TC.DIV_PERSONAL = TSP.DIV_PERSONAL     
     AND TC.SOCIEDAD = TSP.SOCIEDAD     
     AND TC.CONCEPTO = TSP.CONCEPTO     
    WHERE TSP.SOCIEDAD = @SOCIEDAD     
 AND TSP.DIV_PERSONAL = @DIV_PERSONAL     
 AND TSP.EJERCICIO = @EJERCICIO     
 AND TSP.PERIODO = @PERIODO     
 AND TSP.CONCEPTO = '14'    
 AND TSP.VALOR <> 0    
 AND ( CHARINDEX('|' + CONVERT(VARCHAR(12), TSP.LEGAJO) + '|', @LEGAJO) > 0 OR @LEGAJO = '-1' )     
 AND TSP.TIPO_SALIDA = @TIPO_SALIDA     
    GROUP BY TC.DESCRIPCION,    
    TSP.LEGAJO    
    
--------------------------------------------------------------------------------------------     
ORDER  BY TSP.LEGAJO,     
    GPO.GRUPO,   
    FECHA    
    
--------------------------------------------------------------------------------------------     
DROP TABLE #TMPGRUPOS     
DROP TABLE #FECHAS      
DROP TABLE #EMPLEADO      
DROP TABLE #T_SALIDA_PROCESO     
    
--------------------------------------------------------------------------------------------     
SET NOCOUNT OFF