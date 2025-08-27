{{
    config(
        materialized='table',
        schema='gold'
    )
}}
with cte as 
(
    select
        S.s_suppkey as supp_key,
        S.s_name as supp_name,
        S.s_phone as supp_phn,
        S.s_acctbal as supp_act_bal,
        N.n_name as supp_nation,
        R.r_name as supp_region
    from {{ref('supplier_stg')}} S left join {{ref('Nation_stg')}} N on S.s_nationkey=N.n_nationkey
    left join {{ref('Region_stg')}} R on R.r_regionkey=N.n_regionkey
)
select 
    *
from cte