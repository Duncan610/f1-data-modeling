
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select constructor_id
from `f1_project`.`gold`.`dim_driver_constructor`
where constructor_id is null



  
  
      
    ) dbt_internal_test