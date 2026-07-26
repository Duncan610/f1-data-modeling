
    
    

select
    circuit_id as unique_field,
    count(*) as n_records

from `f1_project`.`gold`.`dim_circuit`
where circuit_id is not null
group by circuit_id
having count(*) > 1


