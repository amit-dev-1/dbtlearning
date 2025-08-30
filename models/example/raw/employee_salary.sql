{{
    config(
    materialized='table',
    transient=False,
    schema='Silver')
}}
 
with cte as(
    select
        emp_id as EmployeeId,
        initcap(emp_name) as EmployeeName,
        emp_sal as EmployeeSalary,
        emp_dept as EmpDept,
        case when emp_sal>=12000 then 'A'
        when emp_sal>=10500 and emp_sal <12000 then 'B'
        else 'C' end as EmployeeGrade
    from {{source('Employee_Data','Employee')}}
)
select
    *
from cte
 