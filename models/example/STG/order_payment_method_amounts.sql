{% set v_logid = this.name ~ '_' ~ run_started_at.strftime('%Y%m%d_%H%M%S') %}

{{
    config(
        pre_hook = "
            insert into dbtpractice_dev.silver.model_execution_logs(
                log_id, invocation_id, model_name, start_time, user_name
            ) values (
                '" ~ v_logid ~ "',
                '"~invocation_id~"',
                '" ~ this.name ~ "',
                current_timestamp(),
                current_user()
            )
        ",
        post_hook="
            update dbtpractice_dev.silver.model_execution_logs set end_time=current_timestamp(), execution_status='Success', 
            EXECUTION_TIME_IN_SEC=datediff('sec',start_time, current_timestamp()) where log_id='"~v_logid~"'
        "
    )
}}


{% set payment_methods=get_payments_methods() %}

select
    order_id,
    {% for payment_method in payment_methods %}
    sum(case when payment_method='{{payment_method}}' then amount else 0 end ) as {{payment_method}}_amount,
    {% endfor %}
    sum(amount) as total_amount
from {{ref('raw_payments')}} group by all
