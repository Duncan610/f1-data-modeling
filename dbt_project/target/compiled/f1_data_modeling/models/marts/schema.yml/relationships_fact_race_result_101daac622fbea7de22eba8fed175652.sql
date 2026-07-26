
    
    

with child as (
    select constructor_id as from_field
    from `f1_project`.`gold`.`fact_race_results`
    where constructor_id is not null
),

parent as (
    select constructor_id as to_field
    from `f1_project`.`gold`.`dim_constructor`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


