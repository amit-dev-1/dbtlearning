{{
    config(
        materialized='view',
        database='sales_db',
        schema='silver'
    )
}}

with raw_stg_customers as
(
    select
        customer_id, 
        initcap(customer_name) as customer_name, 
        email, 
        phone, 
        upper(city) as city, 
        upper(state) as state, 
        initcap(country) as country, 
        created_date
    from {{ source('Sales_data', 'RAW_CUSTOMERS') }}
)
select * from raw_stg_customers