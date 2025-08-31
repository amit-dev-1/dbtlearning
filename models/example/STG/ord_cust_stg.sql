{{
    config(
        materialized='table',
        transient=False
    )
}}

with cte as
(
    select
        O.cust_id,
        C.cust_name,
        C.cust_email,
        C.cust_phn,
        O.ord_id,
        O.ord_amt,
        O.ord_date
    from {{source("demo_data","orders")}} O left join {{source("demo_data","customer")}} C
    on O.cust_id=C.cust_id

)
select 
    *
from cte