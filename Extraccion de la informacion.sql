-----------------------------------------------QUERY FINAL SOLO MEDICAMENTO-----------------------------
SELECT
DISTINCT
R.CodigoReferenciaOrigenId AS CodigoInterno,
I.Producto AS NombreInvima,
I.DescripcionComercial AS DescripcionComercial,
I.PrincipioActivo,
I.RegistroSanitario AS CodigoInvima,
I.MedicamentoOrigenId as Cum
FROM Dim.Referencias R
LEFT JOIN Dim.BDMedicamentosInvima I
	ON R.Cum = I.MedicamentoOrigenId
where Anulado = 'N'
AND R.GrupoId = 1
AND R.CodigoReferenciaOrigenId NOT LIKE '%SERV%'
--AND R.Cum is not null

---NOTA: SE LE INSERTO EL DISTINCT ESTO DEBIDO A QUE EN LA BASE DE DATOS DEL INVIMA PUEDE HABER DIFERENTES REGISTROS PARA UN MISMO CUM (MEDICAMENTO)
---NOTA: LOS IGUIENTE EQUIVALE A AQUELLAR REFERENCIAS O PRODUCTOS QUE HACEN PARTE DEL GRUPO DE MEDICAMENTOS (AND R.GrupoId = 1)
---NOTA: EL CUM ES LA REPRESENTACION A NIVEL NACINAL DE UN MEDICAMENTO
---NOTA: EL SIGUIENTE FILTRO LO QUE HACE ES ELIMINAR LAS REFERENCIAS DE TIPO SERVICIO 
---TODO: REMPLASAR LOS CODIGOS INTERNOS POR UN CONSECUTIVO, ESTO PARA MANTENER LA CONFIDENCIALIDAD
---TODO: iDENTIFICAR Y ELIMINAR LOS NULOS
---TODO: MODIFICAR LA CONSULTA SQL DE TAL FORMA QUE ENTIENDA EL PUBLICO Y MANTENGAMOS LA CONFIDENCIALIDA
---NOTA: LAS OTRAS COLUMNAS SE PUEDE ENCONTRAR EN LA PAGINA DEL INVIMA


----------------------------------------------------------------------------------------
SELECT top 10* FROM Dim.BDMedicamentosInvima
where RegistroSanitario = 'INVIMA 2011M-0000632-R1' --ConsecutivoCum = 19901483
--RegistroSanitario = 'INVIMA 2011M-0000632-R1' 

SELECT top 10* FROM Dim.BDMedicamentosInvima
where ExpedienteCum = '19997248' --ConsecutivoCum = 19901483

SELECT * FROM Dim.BDMedicamentosInvima
where ExpedienteCum = '52435' and ConsecutivoCum = '1'

SELECT Cum FROM Dim.Referencias
where CodigoReferenciaOrigenId = 'C625200*B'

SELECT 
COUNT(1)
FROM Dim.Referencias R
where Anulado = 'N'
AND GrupoId = 1
AND CodigoReferenciaOrigenId NOT LIKE '%SERV%'

SELECT 
    RegistroSanitario,
    COUNT(*) AS TotalDuplicados
FROM Dim.BDMedicamentosInvima
WHERE RegistroSanitario IS NOT NULL
GROUP BY RegistroSanitario
HAVING COUNT(*) > 1
ORDER BY TotalDuplicados DESC;

SELECT distinct GrupoId,Grupo,CodigoReferenciaOrigenId,Cum FROM Dim.Referencias
WHERE GrupoId = 83--CodigoReferenciaOrigenId = 'C525013'

SELECT
distinct 
GrupoId,
Grupo,
CodigoReferenciaOrigenId,
Cum
FROM Dim.Referencias
where Grupo like 'Dispositivo%'