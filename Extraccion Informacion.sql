WITH CTE_Distintos AS (
    SELECT DISTINCT
        R.CodigoReferenciaOrigenId AS CodigoInternoOriginal,
        I.Producto AS NombreInvima,
        I.DescripcionComercial AS DescripcionComercial,
        I.PrincipioActivo,
        I.RegistroSanitario AS CodigoInvima,
        I.MedicamentoOrigenId AS Cum
    FROM Dim.Referencias R
    LEFT JOIN Dim.BDMedicamentosInvima I
        ON R.Cum = I.MedicamentoOrigenId
    WHERE R.Anulado = 'N'
      AND R.GrupoId = 1
      AND R.CodigoReferenciaOrigenId NOT LIKE '%SERV%'
)
SELECT  
    ROW_NUMBER() OVER (ORDER BY CodigoInternoOriginal) AS CodigoInterno,
    NombreInvima,
    DescripcionComercial,
    PrincipioActivo,
    CodigoInvima,
    Cum
FROM CTE_Distintos;
