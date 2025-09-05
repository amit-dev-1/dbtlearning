{{
    config(
        materialized='table',
        database='ECOMMERCE_DBS',
        schema='gold',
        incremental_strategy='merge',
        unique_key='customer_id'
    )
}}

with joined as
(
    select  
        customer_id,
        customer_name,
        customer_state,
        customer_country,
        customer_email,
        customer_phone_number,
        cust_cre_dt as cust_cre_dt
    from {{ref("customer_cleaned")}}
),
filtered as
(
    select * from joined
    {% if is_incremental() %}
    where cust_cre_dt >=
    (select max(cust_cre_dt) from {{this}} )

    {% endif %}
)
select * from filtered