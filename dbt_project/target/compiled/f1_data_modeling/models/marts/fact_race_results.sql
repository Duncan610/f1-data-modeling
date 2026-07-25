SELECT
    season,
    round,
    driver_id,
    constructor_id,
    grid AS starting_grid_position,
    finishing_position,
    position_text,
    status_category,
    raw_status,
    points,
    laps,
    total_time_ms,
    fastest_lap_number,
    fastest_lap_avg_speed
FROM `f1_project`.`silver`.`stg_results`