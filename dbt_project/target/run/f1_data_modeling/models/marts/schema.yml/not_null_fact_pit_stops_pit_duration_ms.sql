
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pit_duration_ms
from `f1_project`.`gold`.`fact_pit_stops`
where pit_duration_ms is null



  
  
      
    ) dbt_internal_test