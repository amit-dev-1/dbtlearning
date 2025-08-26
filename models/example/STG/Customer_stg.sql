{{
    config(
        materialized='table',
        schema='silver'
    )
}}

with cte as
(
    select
        C_CUSTKEY,
        C_NAME,
        C_ADDRESS,
        C_NATIONKEY,
        REPLACE(C_PHONE,'-','') AS C_PHONE,
        ROUND(C_ACCTBAL,1) AS C_ACCTBAL,
        UPPER(C_MKTSEGMENT) AS C_MARKET_SEGMENT,
        UPPER(C_COMMENT) AS C_COMMENT
    FROM {{ref('Customer_v')}}
)
select 
    *
from cte