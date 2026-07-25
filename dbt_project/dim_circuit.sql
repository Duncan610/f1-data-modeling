SELECT DISTINCT
    circuit_id,
    circuit_name,
    circuit_locality,
    circuit_country,
    circuit_lat,
    circuit_long,
    circuit_url
FROM {{ ref('stg_races') }}