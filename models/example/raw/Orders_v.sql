{{
    config(
        materialized='view',
        schema='raw'
    )
}}

with cte as
(
    select
        *
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
)
SELECT 
    *
FROM CTE