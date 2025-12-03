{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse='COMPUTE_WH',
        target_lag='1 min'
    )
}}

with item_customers_dt as
(
    select
        C.CUSTOMER_NAME,
        C.EMAIL,
        I.ITEM_NAME AS ITEM_PURCHASE_BY_CUST,
        I.QUANTITY AS TOT_QTY_PURCHASE_BY_CUST,
        I.PRICE AS PRICE_OF_EACH_ITM
    from {{ ref('ITEM_DT') }} I LEFT JOIN {{ ref('CUSTOMERS_DT') }} C ON  C.Customer_id=I.Customer_id
)
SELECT * FROM item_customers_dt
