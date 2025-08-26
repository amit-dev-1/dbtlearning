{{
    config(
        materialized='table',
        schema='gold'
    )
}}

with cte as
(
    select 
        L.l_suppkey as suppkey,
        O.o_custkey as cust_key,
        O.o_orderstatus as orderstatus,
        O.o_totalprice as tot_ord_prc,
        O.o_orderdate as ord_dt,
        O.o_orderpriority as ord_priority,
        O.o_shippriority as ship_priority,
        L.l_linenumber as linenumber,
        L.l_quantity as quantity,
        L.l_extendedprice as tot_ln_itm_prc,
        L.l_discount as discount_on_ln_itm,
        L.l_tax as tax_on_ln_itm,
        L.l_returnflag as ln_itm_rtrn_flg,
        L.l_shipdate as ln_itm_ship_dt,
        L.l_shipinstruct as ln_itm_ship_instruct,
        L.l_shipmode as ln_itm_shipment_md
from {{ref('lineitem_stg')}} L left join {{ref('Orders_stg')}} O on O.o_orderkey=L.l_orderkey 
)
select 
    *
from cte