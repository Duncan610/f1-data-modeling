
  
    
        create or replace table `f1_project`.`gold`.`fact_pit_stops`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      SELECT
    sp.season,
    sp.round,
    d.driver_id,
    sp.pit_lap_number,
    sp.stint,
    sp.pit_in_time_ms,
    sp.pit_out_time_ms,
    sp.pit_duration_ms
FROM `f1_project`.`silver`.`stg_pit_stops` sp
LEFT JOIN `f1_project`.`gold`.`dim_driver` d
    ON sp.driver_code = d.driver_code
  