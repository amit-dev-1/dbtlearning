{{
    config(
        materialized='view',
        database='ECOMMERCE_DBS',
        schema='silver'
    )
}}
with cte as
(
    select
        ord_id,
        cust_id,
        initcap(purchase_itm) as purchase_itm,
        purchase_qty,
        round(tot_amt_spend,1) as tot_amt_spend,
        tot_discount,
        initcap(ord_cmnt) as ord_cmnt,
        decode(upper(ORD_REVEIVED),'YES','Y','NO','N') as ORD_REVEIVED,
        order_date as order_date
    from {{source("Ecommerce dbs","ORDER_RAW")}}
)
select * from cte 