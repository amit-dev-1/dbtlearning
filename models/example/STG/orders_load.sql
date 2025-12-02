{{
    config(
        materialized='table',
        database='demo_db',
        schema='AUDIT'
    )
}}

-- Call macro to log row counts
{{ log_load('DBTPRACTICE_DEV.RAW.EMPLOYEE') }}

WITH source AS (
    SELECT
        *
    FROM DBTPRACTICE_DEV.RAW.EMPLOYEE
)
SELECT * FROM source
