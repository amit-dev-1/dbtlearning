{{
    config(
        materialized='incremental',
        database='sales_db',
        schema='gold',
        incremental_strategy='insert_overwrite',
        partition_by={'field':'order_date','data_type':'date'}
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
    WHERE order_date >= dateadd('day',-3,current_date())
    {% endif %}
)
select * from filterd 