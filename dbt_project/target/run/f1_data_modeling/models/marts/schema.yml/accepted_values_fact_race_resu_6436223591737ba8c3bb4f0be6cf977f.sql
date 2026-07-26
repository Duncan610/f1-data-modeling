
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        status_category as value_field,
        count(*) as n_records

    from `f1_project`.`gold`.`fact_race_results`
    group by status_category

)

select *
from all_values
where value_field not in (
    'Finished','DNF','Disqualified','Other'
)



  
  
      
    ) dbt_internal_test