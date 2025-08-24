{{ config(
    materialized='table',
    schema='silver'
) }}

with cte as
(
    select
        O_TOTALPRICE,
        O_ORDERDATE,
        O_ORDERPRIORITY,
        O_COMMENT
    from dbtpractice.raw.orders_raw
    where O_TOTALPRICE >= 30000 and O_ORDERDATE > '1998-01-01' and O_ORDERPRIORITY in ('2-HIGH', '1-URGENT')
)
select
    *
from cte 