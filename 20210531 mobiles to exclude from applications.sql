#get distinct mobiles
select concat(b.mobile_number,',')
from Warehouse.fact_daily_policy_snapshot a
left join Warehouse.dim_customers b
on a.customer_key = b.customer_key
where a.policy_status_key in (2,3,4,5) #active policies
and a.snapshot_date_key= @date_key
group by b.mobile_number
;

select concat(b.mobile_number,',')
from Warehouse.fact_daily_policy_snapshot a
left join Warehouse.dim_customers b
on a.customer_key = b.customer_key
where a.policy_status_key in (3,4,5)# grace 1, 2, and suspension active policies
and a.snapshot_date_key= @date_key
group by b.mobile_number
;