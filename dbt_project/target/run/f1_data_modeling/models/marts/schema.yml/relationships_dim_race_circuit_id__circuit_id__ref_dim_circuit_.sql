
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select circuit_id as from_field
    from `f1_project`.`gold`.`dim_race`
    where circuit_id is not null
),

parent as (
    select circuit_id as to_field
    from `f1_project`.`gold`.`dim_circuit`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test