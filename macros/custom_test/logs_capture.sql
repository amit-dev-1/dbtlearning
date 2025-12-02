{% macro log_load(table_name) %}
    {% if execute %}
        {% set sql %}
            INSERT INTO DEMO_DB.AUDIT.LOAD_LOG(table_name, row_count, loaded_at)
            SELECT '{{ table_name }}' AS tbl_name,
                COUNT(*) AS cnt,
                CURRENT_TIMESTAMP AS cur_dt
            FROM {{ table_name }}
        {% endset %}
        {% do run_query(sql) %}
    {% endif %}
{% endmacro %}
