SELECT
    CAST(season AS INT) AS season,
    CAST(round AS INT) AS round,
    Driver AS driver_code,
    CAST(DriverNumber AS INT) AS driver_number,
    Team AS team,
    CAST(LapNumber AS INT) AS pit_lap_number,
    CAST(Stint AS INT) AS stint,

    {{ parse_timedelta_ms('PitInTime') }} AS pit_in_time_ms,
    {{ parse_timedelta_ms('PitOutTime') }} AS pit_out_time_ms,

    {{ parse_timedelta_ms('PitOutTime') }} - {{ parse_timedelta_ms('PitInTime') }} AS pit_duration_ms

FROM {{ source('bronze', 'pit_stops_raw') }}