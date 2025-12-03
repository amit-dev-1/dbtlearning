{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse='COMPUTE_WH',
        target_lag='downstream'
    )
}}

with ITEMS as
(
    select * from {{ source('RAW_DATA', 'Items') }} 
    qualify row_number() over (partition by item_id order by created_date desc)=1
)
select * from ITEMS