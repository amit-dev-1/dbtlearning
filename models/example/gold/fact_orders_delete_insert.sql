{{
    config(
        materialized="incremental",
        transient=False,
        database="ECOMMERCE_DBS",
        schema="gold",
        incremental_strategy="delete+insert",
        unique_key="ord_id",
    )
}}
with
    joined as (
        select
            o.ord_id,
            o.cust_id,
            o.purchase_qty,
            o.tot_amt_spend,
            o.tot_discount,
            c.customer_bank_balance,
            o.order_date as order_date
        from {{ ref("orders_cleaned") }} o
        left join {{ ref("customer_cleaned") }} c on o.cust_id = c.customer_id
    ),
    filtered as (
        select *
        from joined
        {% if is_incremental() %}
            where order_date >= dateadd('day', -2, current_timestamp())
        {% endif %}
    )
select *
from filtered
