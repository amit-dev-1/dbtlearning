{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse='COMPUTE_WH',
        target_lag='downstream'
    )
}}

with Customers as
(
    select * from {{ source('RAW_DATA', 'customers') }} 
    qualify row_number() over (partition by Customer_id order by created_date desc)=1
)
select * from Customers