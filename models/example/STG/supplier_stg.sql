{{
    config(
        materialized='table',
        schema='silver'
    )
}}

with cte as
(
    select
        s_suppkey,
        s_name,
        s_nationkey,
        replace(s_phone,'-','') as s_phone,
        s_acctbal,
        upper(s_comment) as s_comment
    from {{ref('supplier_v')}}
)
select 
    *
from cte 