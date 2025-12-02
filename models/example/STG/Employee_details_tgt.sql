-- models/stg/employee_details_tgt.sql
{{
  config(
    materialized='table',
    post_hook=[
  recons_audit_logs(
    'DBTPRACTICE_DEV.RAW.SRC_EMPLOYEE_DETAILS',
    'DBTPRACTICE_DEV.silver.Employee_details_tgt'
  )
]
  )
}}

WITH cte AS (
  SELECT
    emp_id,
    INITCAP(first_name) AS first_name,
    INITCAP(last_name)  AS last_name,
    dept_name,
    job_title,
    ROUND(salary, 2)    AS salary,
    hire_date,
    email,
    phone
  FROM {{ source('DBT PRACTICE','SRC_EMPLOYEE_DETAILS') }}
)
SELECT * FROM cte
