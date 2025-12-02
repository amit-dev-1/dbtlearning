{% set db_name='dbtpractice_dev' %}
{% set schema = 'PUBLIC' %}
{% set stage_name='my_int_stg' %}
{% set file_format = "TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY='\"'" %}

{{ intr_stg(
    db_name=db_name,
    schema_name=schema,
    stage_name=stage_name,
    file_format=file_format
) }}
SELECT 'Stage created successfully' AS status