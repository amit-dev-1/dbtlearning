{{
    config(
        materialized='table',
        schema='gold'
    )
}}

with cte as
(
    select 
        C.C_CUSTKEY,
        C.C_NAME,
        C.C_ADDRESS,
        C.C_PHONE,
        C.C_ACCTBAL,
        C.C_MARKET_SEGMENT,
        N.n_Name as nation_name,
        R.r_name as region_name
    from {{ref('Customer_stg')}} C left join {{ref('Nation_stg')}} N on C.C_NATIONKEY=N.n_nationkey
    left join {{ref('Region_stg')}} R on R.r_regionkey=N.n_regionkey
)
select 
    *
from cte 