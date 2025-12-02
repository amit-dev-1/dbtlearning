{% macro get_column_values(column_name,relation) %}
{% set payment_methods_query %}
select distinct
{{column_name}}
from {{ relation }}
order by 1
{% endset %}
{% if execute %}
    {% set results = run_query(payment_methods_query) %}
    {% set results_list=results.columns[0].values() %}
    {{ log("Results: " ~ results_list ,info=True) }}
{% else %}
    {% set results_list=[] %}
{% endif %}
{{ log("Macro compilation complete ", info=True) }}
{{ return(results_list) }}
{% endmacro %}

{% macro get_payments_methods() %}
    {{ return(get_column_values('PAYMENT_METHOD', ref('raw_payments') )) }}
{% endmacro %}