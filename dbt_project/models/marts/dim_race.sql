SELECT
    season,
    round,
    race_name,
    race_date,
    circuit_id,
    first_practice,
    second_practice,
    third_practice,
    qualifying,
    sprint,
    sprint_qualifying,
    sprint_shootout,
    race_url
FROM {{ ref('stg_races') }}