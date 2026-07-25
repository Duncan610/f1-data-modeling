SELECT
    season,
    round,
    race_name,
    race_date,
    circuit_id,
    first_practice_ts,
    second_practice_ts,
    third_practice_ts,
    qualifying_ts,
    sprint_ts,
    sprint_qualifying_ts,
    sprint_shootout_ts,
    race_url
FROM {{ ref('stg_races') }}