{{
    config(
        materialized='table',
        schema='silver'
    )
}}

with cte as
(
    select
        *
    from {{ref('lineitem_v')}}
)
SELECT 
    *
FROM CTE