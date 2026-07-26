
  
    
        create or replace table `f1_project`.`gold`.`dim_race`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      SELECT
    season,
    round,
    race_name,
    race_date,
    circuit_id,
    first_practice,
    second_practice,
    third_practice,
    qualifying,
    sprint,
    sprint_qualifying,
    sprint_shootout,
    race_url
FROM `f1_project`.`silver`.`stg_races`
  