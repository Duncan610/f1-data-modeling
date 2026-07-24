
  
  
  
  create or replace view `f1_project`.`silver`.`stg_results`
  
  as (
    SELECT
  Constructor.constructorId AS constructor_id,
  Constructor.name AS constructor_name,
  Constructor.nationality AS constructor_nationality,
  Constructor.url AS constructor_url,

  Driver.driverId AS driver_id,
  Driver.code AS driver_code,
  CAST(Driver.dateOfBirth AS DATE) AS driver_date_of_birth,
  Driver.familyName AS driver_family_name,
  Driver.givenName AS driver_given_name,
  Driver.nationality AS driver_nationality,
  Driver.url AS driver_url,
  CAST(Driver.permanentNumber AS INT) AS driver_permanent_number,

  CAST(FastestLap.AverageSpeed.speed AS DOUBLE) AS fastest_lap_avg_speed,
  FastestLap.AverageSpeed.units AS fastest_lap_avg_speed_units,
  FastestLap.Time.time AS fastest_lap_time_raw,
  CAST(FastestLap.lap AS INT) AS fastest_lap_number,
  CAST(FastestLap.rank AS INT) AS fastest_lap_rank,

  CAST(position AS INT) AS finishing_position,
  positionText AS position_text,

  CAST(Time.millis AS BIGINT) AS total_time_ms,
  Time.time AS race_time_or_gap_raw,

  CAST(grid AS INT) AS grid,
  CAST(laps AS INT) AS laps,
  CAST(number AS INT) AS driver_number,
  CAST(points AS DOUBLE) AS points,
  raceName AS race_name,
  CAST(round AS INT) AS round,
  CAST(season AS INT) AS season,
  status AS raw_status,

  CASE
    WHEN status = 'Finished' THEN 'Finished'
    WHEN status LIKE '+%Lap%' THEN 'Finished'
    WHEN status = 'Lapped' THEN 'Finished'
    WHEN status IN ('Disqualified', 'DSQ') THEN 'Disqualified'
    WHEN status IN ('Retired', 'Accident', 'Collision', 'Engine',
                     'Gearbox', 'Mechanical', 'Suspension', 'Brakes',
                     'Hydraulics', 'Electrical', 'Power Unit', 'Puncture') THEN 'DNF'
    ELSE 'Other'
  END AS status_category

FROM `f1_project`.`bronze`.`results_raw`
  )
