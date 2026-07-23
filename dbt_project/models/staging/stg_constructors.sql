WITH deduped AS(
    SELECT  
        constructorId AS constructor_id,
        name AS driver_name,
        nationality AS driver_nationality,
        season,
        url,
        ROW_NUMBER() OVER(PARTITION BY constructorId ORDER BY season DESC) AS rn
    FROM {{ source('bronze', 'constructors_raw') }}
)
SELECT
    constructor_id,
    driver_name,
    driver_nationality,
    season,
    url
FROM deduped
WHERE rn = 1