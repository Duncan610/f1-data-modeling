SELECT
    CAST(season AS INT) AS season,
    CAST(round AS INT) AS round,
    Driver AS driver_code,
    CAST(DriverNumber AS INT) AS driver_number,
    Team AS team,

    {{ parse_timedelta_ms('Time') }} AS session_time_ms,
    {{ parse_timedelta_ms('LapTime') }} AS lap_time_ms,
    CAST(LapNumber AS INT) AS lap_number,
    CAST(Stint AS INT) AS stint,

    {{ parse_timedelta_ms('PitOutTime') }} AS pit_out_time_ms,
    {{ parse_timedelta_ms('PitInTime') }} AS pit_in_time_ms,

    {{ parse_timedelta_ms('Sector1Time') }} AS sector1_time_ms,
    {{ parse_timedelta_ms('Sector2Time') }} AS sector2_time_ms,
    {{ parse_timedelta_ms('Sector3Time') }} AS sector3_time_ms,

    SpeedI1 AS speed_i1,
    SpeedI2 AS speed_i2,
    SpeedFL AS speed_fl,
    SpeedST AS speed_st,

    CAST(IsPersonalBest AS BOOLEAN) AS is_personal_best,
    Compound AS tyre_compound,
    CAST(TyreLife AS INT) AS tyre_life,
    cast(FreshTyre AS BOOLEAN) AS fresh_tyre,

    CAST(TrackStatus AS INT) AS track_status,
    CAST(POSITION AS INT) AS POSITION,
    CAST(Deleted AS BOOLEAN) AS is_deleted,
    NULLIF(DeletedReason, '') AS deleted_reason,
    CAST(IsAccurate AS BOOLEAN) AS is_accurate

FROM {{ source('bronze', 'laps_raw') }}