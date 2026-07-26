
    
    

with child as (
    select driver_id as from_field
    from `f1_project`.`gold`.`dim_driver_constructor`
    where driver_id is not null
),

parent as (
    select driver_id as to_field
    from `f1_project`.`gold`.`dim_driver`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


