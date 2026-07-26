
  
    
        create or replace table `f1_project`.`gold`.`fact_lap_times`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      WITH laps_with_driver_id AS (
    SELECT
        l.season,
        l.round,
        d.driver_id,
        l.lap_number,
        l.stint,
        l.lap_time_ms,
        l.position,
        l.session_time_ms,
        l.sector1_time_ms,
        l.sector2_time_ms,
        l.sector3_time_ms,
        l.tyre_compound,
        l.tyre_life,
        l.fresh_tyre,
        l.is_personal_best,
        l.is_accurate,
        l.track_status
    FROM `f1_project`.`silver`.`stg_laps` l
    LEFT JOIN `f1_project`.`gold`.`dim_driver` d
        ON l.driver_code = d.driver_code
),

leader_time_per_lap AS (
    SELECT
        season,
        round,
        lap_number,
        MIN(session_time_ms) AS leader_session_time_ms
    FROM laps_with_driver_id
    WHERE position = 1
    GROUP BY season, round, lap_number
)

SELECT
    lwd.season,
    lwd.round,
    lwd.driver_id,
    lwd.lap_number,
    lwd.stint,
    lwd.lap_time_ms,
    lwd.position,
    lwd.session_time_ms - lt.leader_session_time_ms AS gap_to_leader_ms,
    lwd.sector1_time_ms,
    lwd.sector2_time_ms,
    lwd.sector3_time_ms,
    lwd.tyre_compound,
    lwd.tyre_life,
    lwd.fresh_tyre,
    lwd.is_personal_best,
    lwd.is_accurate,
    lwd.track_status
FROM laps_with_driver_id lwd
LEFT JOIN leader_time_per_lap lt
    ON lwd.season = lt.season
    AND lwd.round = lt.round
    AND lwd.lap_number = lt.lap_number
  