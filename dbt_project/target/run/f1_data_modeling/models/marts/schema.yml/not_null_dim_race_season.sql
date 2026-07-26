
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select season
from `f1_project`.`gold`.`dim_race`
where season is null



  
  
      
    ) dbt_internal_test