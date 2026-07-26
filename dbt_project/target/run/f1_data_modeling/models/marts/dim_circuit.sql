
  
    
        create or replace table `f1_project`.`gold`.`dim_circuit`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      SELECT DISTINCT
    circuit_id,
    circuit_name,
    circuit_locality,
    circuit_country,
    circuit_lat,
    circuit_long,
    circuit_url
FROM `f1_project`.`silver`.`stg_races`
  