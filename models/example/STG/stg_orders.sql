{{
    config(
        materialized='table',
        transient=True,
        schema='silver'
    )
}}

with cte as
(
    select
        c.customer_id,
        c.name,
        c.email,
        o.order_id,
        o.order_date,
        o.total_amount
    from {{source("Ecommerce","RAW_CUSTOMERS")}} c inner join {{source("Ecommerce","RAW_ORDERS")}} o
    on c.customer_id=o.customer_id
)
select
    *
from cte