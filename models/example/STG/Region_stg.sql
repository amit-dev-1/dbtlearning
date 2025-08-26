{{
    config(
        materialized='table',
        schema='silver'
    )
}}

with cte as
(
    select
        r_regionkey,
        r_name,
        upper(r_comment) as r_comment
    from {{ref('Region_v')}}
)
select
    *
from cte