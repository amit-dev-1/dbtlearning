{{
    config(
        materialized="table",
        schema="gold",
        database="ECOMMERCE_DBS",
        incremental_strategy="merge",
        unique_key="ord_id",
    )
}}

with
    details as (
        select
            ord_id,
            purchase_itm,
            ord_cmnt as cust_cmnt,
            ord_reveived as ord_delivered,
            order_date as order_date
        from {{ ref("orders_cleaned") }}
    ),
    filtered as (
        select *
        from details
        {% if is_incremental() %}
            where order_date >= (select max(order_date) from {{ this }})
        {% endif %}
    )
select *
from filtered
