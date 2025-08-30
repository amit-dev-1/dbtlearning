{{
    config(
        materialized='view',
        secured=false,
        schema='gold'
    )
}}
with cte as
(
    select
        EmpDept,
        max(EmployeeSalary) as max_sal,
        sum(EmployeeSalary) as tot_sal
    from {{ref("employee_salary")}}
    group by EmpDept
)
select 
    * 
from cte
