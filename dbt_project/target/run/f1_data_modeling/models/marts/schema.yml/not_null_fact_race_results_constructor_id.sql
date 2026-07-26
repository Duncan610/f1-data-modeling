
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select constructor_id
from `f1_project`.`gold`.`fact_race_results`
where constructor_id is null



  
  
      
    ) dbt_internal_test