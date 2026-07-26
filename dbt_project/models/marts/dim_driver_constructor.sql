WITH driver_constructor_seasons AS (
    SELECT DISTINCT
        season,
        driver_id,
        constructor_id
    FROM {{ ref('stg_results') }}
)

SELECT
    driver_id,
    constructor_id,
    season,
    season = MAX(season) OVER (PARTITION BY driver_id) AS is_current
FROM driver_constructor_seasons