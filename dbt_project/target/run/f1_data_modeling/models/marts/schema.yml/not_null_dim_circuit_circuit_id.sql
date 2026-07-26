
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select circuit_id
from `f1_project`.`gold`.`dim_circuit`
where circuit_id is null



  
  
      
    ) dbt_internal_test