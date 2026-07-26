
  
    
        create or replace table `f1_project`.`gold`.`dim_constructor`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      SELECT
    constructor_id,
    driver_name,
    driver_nationality,
    url
FROM `f1_project`.`silver`.`stg_constructors`
  