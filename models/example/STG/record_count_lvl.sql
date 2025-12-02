{% set emails=('amit123js@gmai.com') %}
{% set count_query %}
    select count(*) from SECONDARY_DB.SEC_SCHEMA.CUSTOMER
{% endset %}
{% set result = run_query(count_query) %}
{% if result %}
    {% set row_count=result.columns[0].values()[0] %}
    {% if row_count > 10000 %}
        {{email_ntf(
            'my_ntf_int',
            'amit123js@gmail.com',
            'Alert-High Data',
            'Your table Customer contain high level of records count - '~row_count~'\n please check pipeline'
        )}}
    {% endif %}
{% endif %}
select CURRENT_TIMESTAMP() as current_time