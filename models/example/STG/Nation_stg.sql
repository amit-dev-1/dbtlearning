{{
    config(
        materialized='table',
        schema='silver'
    )
}}

with cte as
(   
    select
        n_nationkey,
        n_name,
        n_regionkey,
        upper(n_comment) as comment
    from {{ref('NATION_v')}}
)
Select 
    *
from cte