{% snapshot Customer_snapshot %}
{{
    config(
        unique_key='order_id',
        strategy='timestamp',
        update_at='CREATED_DATE',
        invalidate_hard_deletes=True
    )
}}

select * from {{ source('Customer_data', 'Customer') }}

{% endsnapshot %}