
  
  
  
  create or replace view `f1_project`.`silver`.`stg_pit_stops`
  
  as (
    SELECT
    CAST(season AS INT) AS season,
    CAST(round AS INT) AS round,
    Driver AS driver_code,
    CAST(DriverNumber AS INT) AS driver_number,
    Team AS team,
    CAST(LapNumber AS INT) AS pit_lap_number,
    CAST(Stint AS INT) AS stint,

    
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
        when PitOutTime is null or PitOutTime in ('NaT', '-') then null
        else
            cast(regexp_extract(PitOutTime, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(PitOutTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 - 
    case
        when PitInTime is null or PitInTime in ('NaT', '-') then null
        else
            cast(regexp_extract(PitInTime, '^(\\d+) days', 1) as bigint) * 86400000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + cast(regexp_extract(PitInTime, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
 AS pit_duration_ms

FROM `f1_project`.`bronze`.`pit_stops_raw`
  )
