WITH laps_with_pit_events AS (
    SELECT
        CAST(season AS INT) AS season,
        CAST(round AS INT) AS round,
        Driver AS driver_code,
        CAST(DriverNumber AS INT) AS driver_number,
        Team AS team,
        CAST(LapNumber AS INT) AS lap_number,
        CAST(Stint AS INT) AS stint,
        {{ parse_timedelta_ms('PitInTime') }} AS pit_in_time_ms,
        {{ parse_timedelta_ms('PitOutTime') }} AS pit_out_time_ms
    FROM {{ source('bronze', 'laps_raw') }}
    WHERE PitInTime IS NOT NULL AND PitInTime NOT IN ('NaT', '-', '')
       OR PitOutTime IS NOT NULL AND PitOutTime NOT IN ('NaT', '-', '')
),

paired AS (
    SELECT
        season,
        round,
        driver_code,
        driver_number,
        team,
        lap_number AS pit_lap_number,
        stint,
        pit_in_time_ms,
        LEAD(pit_out_time_ms) OVER (
            PARTITION BY season, round, driver_code
            ORDER BY lap_number
        ) AS next_pit_out_time_ms
    FROM laps_with_pit_events
)

SELECT
    season,
    round,
    driver_code,
    driver_number,
    team,
    pit_lap_number,
    stint,
    pit_in_time_ms,
    next_pit_out_time_ms AS pit_out_time_ms,
    next_pit_out_time_ms - pit_in_time_ms AS pit_duration_ms
FROM paired
WHERE pit_in_time_ms IS NOT NULL