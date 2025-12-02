{% set cols=['Product_id','product_name','price','category','country_code','stock_date'] %}
{{
    config(
        materialized='incremental',
        transient=False,
        unique_key=['Product_id', 'country_code'],
        incremental_strtegy='merge'
        )
}}
with all_region_product as
(
    {{required_columns("Product_Australia",cols)}}
    union
    {{required_columns("Product_canada",cols)}}
    union
    {{required_columns("Product_china",cols)}}
    union
    {{required_columns("Product_India",cols)}}
    union
    {{required_columns("Product_singapore",cols)}}
),
filtered as
(
    select * from all_region_product
    {% if is_incremental() %}
    where stock_date >= (select max(rec_cre_dt) from {{this}})
    {% endif %}
)
select * from filtered