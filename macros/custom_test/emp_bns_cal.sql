{% macro emp_bonus(salary, bonus_pct)%}
    {{salary}}*{{bonus_pct}}*0.01 as employee_bonus,
    {{salary}}*{{bonus_pct}}*0.01+{{salary}} as employee_tot_salary
{% endmacro %}