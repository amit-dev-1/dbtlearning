{% test valid_email_id(model,column_name) %}
select
    *
from {{model}} where {{column_name}} not regexp '[\\w\.]+[@][\\w\.]+[a-zA-Z]+'
{% endtest %}