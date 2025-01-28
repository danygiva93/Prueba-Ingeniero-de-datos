-- Parámetros
SET @fecha_base = '2024-12-01'; -- Define la fecha base

-- Paso 1: Clasificar saldos por niveles con la fecha base
WITH niveles AS (
    SELECT 
        cal.identificacion,
        cal.mes AS corte_mes,
        COALESCE(h.saldo, 0) AS saldo,
        CASE
            WHEN h.saldo IS NULL THEN 'N0'
            WHEN h.saldo >= 0 AND h.saldo < 300000 THEN 'N0'
            WHEN h.saldo >= 300000 AND h.saldo < 1000000 THEN 'N1'
            WHEN h.saldo >= 1000000 AND h.saldo < 3000000 THEN 'N2'
            WHEN h.saldo >= 3000000 AND h.saldo < 5000000 THEN 'N3'
            WHEN h.saldo >= 5000000 THEN 'N4'
            ELSE 'N0'
        END AS nivel
    FROM (
        -- Generación del calendario (todas las combinaciones de cliente y mes)
        SELECT 
            c.identificacion,
            m.mes
        FROM (
            SELECT DISTINCT identificacion 
            FROM glpidb.TBL_HISTORIA
        ) c
        CROSS JOIN (
            SELECT DISTINCT DATE_FORMAT(STR_TO_DATE(corte_mes, '%c/%e/%y'), '%Y-%m-01') AS mes
            FROM glpidb.TBL_HISTORIA
            WHERE STR_TO_DATE(corte_mes, '%c/%e/%y') <= STR_TO_DATE(@fecha_base, '%Y-%m-%d')
        ) m
    ) cal
    LEFT JOIN glpidb.TBL_HISTORIA h
        ON cal.identificacion = h.identificacion
        AND DATE_FORMAT(STR_TO_DATE(h.corte_mes, '%c/%e/%y'), '%Y-%m-01') = cal.mes
    WHERE cal.mes <= STR_TO_DATE(@fecha_base, '%Y-%m-%d')   
),
-- Paso 2: Identificar meses consecutivos por nivel
con_rachas AS (
    SELECT 
        identificacion,
        nivel,
        corte_mes,
        -- Usamos TIMESTAMPDIFF para obtener la diferencia en meses entre las fechas consecutivas
        TIMESTAMPDIFF(MONTH, LAG(corte_mes, 1) OVER (PARTITION BY identificacion, nivel ORDER BY corte_mes), corte_mes) AS diff_meses
    FROM niveles
),
agrupar_rachas AS (
    SELECT 
        identificacion,
        nivel,
        corte_mes,
        -- Identificamos las rachas consecutivas con diff_meses, reiniciando cuando la diferencia no es 1 mes
        SUM(CASE WHEN diff_meses = 1 THEN 0 ELSE 1 END) 
            OVER (PARTITION BY identificacion, nivel ORDER BY corte_mes) AS racha_id
    FROM con_rachas
)

SELECT 
    identificacion,
    racha,
    fecha_fin,    
    nivel
FROM (
    SELECT 
        identificacion,
        nivel,
        racha_id,
        COUNT(*) AS racha,  -- Número de meses consecutivos
        MAX(corte_mes) AS fecha_fin,  -- Última fecha de la racha
        RANK() OVER (PARTITION BY identificacion, nivel ORDER BY COUNT(*) DESC, MAX(corte_mes) DESC) AS rank_racha  -- Ranking por número de meses (de mayor a menor)
    FROM agrupar_rachas
    GROUP BY identificacion, nivel, racha_id
    HAVING COUNT(*) = 3  -- Filtrar las rachas con al menos 3 meses consecutivos
) AS rachas_filtradas
WHERE rank_racha = 1  -- Seleccionar solo la racha más larga
ORDER BY identificacion, nivel;