{{
    config(
        materialized='incremental',
        schema='gold',
        database='ECOMMERCE_DBS',
        incremental_strategy='merge',
        unique_key='ord_id'
    )
}}
with joined as
(
    select
        o.ord_id,
        o.cust_id,
        o.purchase_qty,
        o.TOT_AMT_SPEND,
        o.tot_discount,
        c.customer_bank_balance,
        o.order_date as order_date
    from {{ref("orders_cleaned")}} o left join {{ref("customer_cleaned")}} c on o.cust_id=c.customer_id
),
filtered as
(
    select * from joined
    {% if is_incremental() %}
    where order_date >=
    (select coalesce(max(order_date),'1990-01-01') from {{this}} )

    {% endif %}
)
select * from filtered
