{% macro email_ntf(integration_name,emails,subject,email_content) %}
    {% set sql %}
    call system$send_email('{{integration_name}}','{{emails}}','{{subject}}','{{email_content}}')
    {% endset %}
    {% do log('Sending email : subject -> '~subject, info=True) %}
    {% do run_query(sql) %}
{% endmacro %}