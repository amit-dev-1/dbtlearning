{{
    config(
        materialized='table',
        schema='silver'
    )
}}

with cte as
(
    select
        o_orderkey,
        o_custkey,
        o_orderstatus,
        round(o_totalprice,0) as o_totalprice,
        to_char(o_orderdate,'dd-mon-yyyy') as o_orderdate,
        o_orderpriority,
        o_clerk,
        o_shippriority,
        upper(o_comment) as o_comment
    from {{ref('Orders_v')}}
)
select
    *
from cte