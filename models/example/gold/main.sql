{{
    config(
        materialized='table',
        schema='gold'
    )
}}

with cte as
(
    select * from {{ref('upstr')}} where emp_id=1
)
select * from cte