{{
    config(
        materialized='incremental',
        database='sales_db',
        schema='gold',
        incremental_strategy='delete_insert',
        unique_key=('order_id')
    )
}}

with sales_analytics_insert_overwrite as 
(
    select 
        o.order_id,
        c.customer_name, 
        c.state, 
        o.price_per_unit, 
        o.product_name, 
        o.quantity, 
        o.total_amount,
        o.order_date 
    from {{ ref('stg_raw_orders') }} o left join {{ ref('stg_raw_customers') }} c 
    on o.customer_id=c.customer_id 
),
filterd as
(
    select * from sales_analytics_insert_overwrite
    {% if is_incremental() %}
    where order_date >= (select coalesce(max(order_date),'1999-01-01'::date) from {{this}} )
    {% endif %}
)
select * from filterd 