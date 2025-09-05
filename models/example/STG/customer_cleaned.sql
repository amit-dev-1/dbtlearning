{{
    config(materialized='view',
    schema='silver')
}}

with cte as
(
    select
        cust_id as customer_id,
        cust_name as customer_name,
        cust_state as customer_state,
        initcap(cust_cntry) as customer_country,
        cust_email as customer_email,
        round(cust_bank_bal,1) as customer_bank_balance,
        substr(cust_phn,4) as customer_phone_number,
        cust_cre_dt as cust_cre_dt
    from {{source("Ecommerce dbs","CUST_RAW")}}
)
select * from cte 