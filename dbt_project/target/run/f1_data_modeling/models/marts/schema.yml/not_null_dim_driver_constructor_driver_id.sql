
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select driver_id
from `f1_project`.`gold`.`dim_driver_constructor`
where driver_id is null



  
  
      
    ) dbt_internal_test