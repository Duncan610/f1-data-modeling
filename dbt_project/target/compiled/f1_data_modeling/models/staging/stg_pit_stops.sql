WITH laps_with_pit_events AS (
    SELECT
        CAST(season AS INT) AS season,
        CAST(round AS INT) AS round,
        Driver AS driver_code,
        CAST(DriverNumber AS INT) AS driver_number,
        Team AS team,
        CAST(LapNumber AS INT) AS lap_number,
        CAST(Stint AS INT) AS stint,
        
    case
        when PitInTime is null or PitInTime in ('NaT', '-', '') then null
        else
            try_cast(regexp_extract(PitInTime, '^(\\d+) days', 1) as bigint) * 86400000
            + try_cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + try_cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + try_cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + try_cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS pit_in_time_ms,
        
    case
        when PitOutTime is null or PitOutTime in ('NaT', '-', '') then null
        else
            try_cast(regexp_extract(PitOutTime, '^(\\d+) days', 1) as bigint) * 86400000
            + try_cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + try_cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + try_cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + try_cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS pit_out_time_ms
    FROM `f1_project`.`bronze`.`laps_raw`
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