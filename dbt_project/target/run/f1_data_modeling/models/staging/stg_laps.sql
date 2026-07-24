
  
  
  
  create or replace view `f1_project`.`silver`.`stg_laps`
  
  as (
    SELECT
    CAST(season AS INT) AS season,
    CAST(round AS INT) AS round,
    Driver AS driver_code,
    CAST(DriverNumber AS INT) AS driver_number,
    Team AS team,

    
    case
        when Time is null or Time in ('NaT', '-') then null
        else
            cast(regexp_extract(Time, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS session_time_ms,
    
    case
        when LapTime is null or LapTime in ('NaT', '-') then null
        else
            cast(regexp_extract(LapTime, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(LapTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(LapTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(LapTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(LapTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS lap_time_ms,
    CAST(LapNumber AS INT) AS lap_number,
    CAST(Stint AS INT) AS stint,

    
    case
        when PitOutTime is null or PitOutTime in ('NaT', '-') then null
        else
            cast(regexp_extract(PitOutTime, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS pit_out_time_ms,
    
    case
        when PitInTime is null or PitInTime in ('NaT', '-') then null
        else
            cast(regexp_extract(PitInTime, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS pit_in_time_ms,

    
    case
        when Sector1Time is null or Sector1Time in ('NaT', '-') then null
        else
            cast(regexp_extract(Sector1Time, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(Sector1Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(Sector1Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(Sector1Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(Sector1Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS sector1_time_ms,
    
    case
        when Sector2Time is null or Sector2Time in ('NaT', '-') then null
        else
            cast(regexp_extract(Sector2Time, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(Sector2Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(Sector2Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(Sector2Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(Sector2Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS sector2_time_ms,
    
    case
        when Sector3Time is null or Sector3Time in ('NaT', '-') then null
        else
            cast(regexp_extract(Sector3Time, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(Sector3Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(Sector3Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(Sector3Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(Sector3Time, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS sector3_time_ms,

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

FROM `f1_project`.`bronze`.`laps_raw`
  )
