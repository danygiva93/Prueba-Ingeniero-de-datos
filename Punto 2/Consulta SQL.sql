-- Consulta SQL para identificar las categorías preferidas por cliente dentro de una ventana temporal

WITH Preferencias AS (
    SELECT
        t.IDENTIFICACION,
        c.NOMBRE_CATEGORIA,
        COUNT(t.ID_TRANSACCION) AS TOTAL_TRANSACCIONES,  -- Contamos las transacciones por categoría
        MAX(STR_TO_DATE(t.FECHA_TRANSACCION, '%m/%d/%y')) AS ULTIMA_FECHA  -- Obtenemos la última fecha de transacción
    FROM
        glpidb.TBL_TRANSACCIONES t
    JOIN glpidb.TBL_CATEGORIAS_CONSUMO c
        ON t.CODIGO_CATEGORIA = c.CODIGO_CATEGORIA
    WHERE
        t.ESTADO = 'Aprobada'  -- Filtramos solo las transacciones aprobadas
        AND STR_TO_DATE(t.FECHA_TRANSACCION, '%m/%d/%y') BETWEEN '2004-01-01' AND '2025-12-31'  -- Establecemos el periodo de tiempo deseado
    GROUP BY
        t.IDENTIFICACION, c.NOMBRE_CATEGORIA
),

-- CTE para rankear las preferencias por cliente
RankingPreferencias AS (
    SELECT
        p.IDENTIFICACION,
        p.NOMBRE_CATEGORIA,
        p.TOTAL_TRANSACCIONES,
        p.ULTIMA_FECHA,
        -- Rankeamos las categorías por cliente, ordenando primero por la cantidad de transacciones y luego por la ultima fecha
        RANK() OVER (
            PARTITION BY p.IDENTIFICACION
            ORDER BY p.TOTAL_TRANSACCIONES DESC, p.ULTIMA_FECHA DESC
        ) AS RANKING
    FROM
        Preferencias p
)

-- Consulta final que selecciona las categorías preferidas para cada cliente
SELECT
    rp.IDENTIFICACION,
    rp.NOMBRE_CATEGORIA AS CATEGORIA_PREFERIDA,
    rp.TOTAL_TRANSACCIONES,
    rp.ULTIMA_FECHA,
    rp.RANKING
FROM
    RankingPreferencias rp
WHERE
    rp.RANKING <= 2  -- Obtenemos las dos categorias preferidas por cliente
ORDER BY
    rp.IDENTIFICACION, rp.RANKING;  -- Ordenamos por cliente y ranking
