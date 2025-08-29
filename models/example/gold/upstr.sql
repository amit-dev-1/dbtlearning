with cte as
(
    select 1 as emp_id, 20000 as emp_sal
        union all
    select 2 as emp_id, 15000 as emp_sal
)
select
    *
from cte