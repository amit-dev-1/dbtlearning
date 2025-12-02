{{
    config(
        materialized='view',
        database='sales_db',
        schema='silver'
    )
}}
with raw_stg_orders as
(
    select 
        order_id, 
        customer_id,
        order_date, 
        initcap(product_name) as product_name, 
        quantity, 
        round(price_per_unit,2) as price_per_unit, 
        round(total_amount,2) as total_amount
    from {{ source('Sales_data', 'RAW_ORDERS') }}
)
select * from raw_stg_orders 
