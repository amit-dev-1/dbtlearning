{% macro intr_stg(db_name,schema_name,stage_name,file_format='') %}
    {% set sql %}
        create stage if not exists {{db_name}}.{{schema_name}}.{{stage_name}}
        file_format=({{file_format}})
    {% endset %}
    {% do log("Executing sql : "~sql, info=True) %}    
    {% do run_query(sql) %}
{% endmacro %}