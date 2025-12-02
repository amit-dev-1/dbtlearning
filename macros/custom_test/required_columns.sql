{% macro required_columns(table, columns) %}
    select {{ columns | join(', ') }},
            current_timestamp() as rec_cre_dt 
    from {{ source("DBT PRACTICE", table) }}
{% endmacro %}