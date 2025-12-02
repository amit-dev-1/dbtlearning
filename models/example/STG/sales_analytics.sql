{{
    config(
        materialized='table',
        database='sales_db',
        schema='silver'
    )
}}

with sales_analytics as 
(
    select 
        c.customer_name, 
        c.state, 
        o.price_per_unit, 
        o.product_name, 
        o.quantity, 
        o.total_amount 
    from {{ source('Sales_data', 'RAW_ORDERS') }} o left join {{ source('Sales_data', 'RAW_CUSTOMERS') }} c 
    on o.customer_id=c.customer_id 
)
select * from sales_analytics 