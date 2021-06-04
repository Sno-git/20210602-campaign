#set the max snapshot date
set @date_key = date_sub(date(now()), interval 1 day);

select @date_key;

#applications remove all numbers with an active account
select a.customer_key, b.first_name, b.last_name, b.mobile_number, count(*)
from Warehouse.fact_daily_policy_snapshot a
left join Warehouse.dim_customers b
on a.customer_key = b.customer_key
where a.policy_status_key = 1
and b.mobile_number not in (0) # paste list of mobile numbers in active policy list
and a.snapshot_date_key= @date_key
group by b.mobile_number
;
#5055



#grace 1 2 and suspension and product. 
#You will make 6 different lists
select a.customer_key, b.first_name, b.last_name, b.mobile_number, 
a.policy_status_key, e.status_description, a.product_type_key, d.product_name,a.suspension_date 
from Warehouse.fact_daily_policy_snapshot a
left join Warehouse.dim_customers b
on a.customer_key = b.customer_key
left join Warehouse.dim_product_type d
on a.product_type_key=d.product_type_key
left join Warehouse.dim_policy_status e
on a.policy_status_key=e.policy_status_key
where a.policy_status_key in (5)
/*and a.policy_status_key = (select max(c.policy_status_key)
from Warehouse.fact_daily_policy_snapshot c
where a.customer_key = c.customer_key)*/ #a fancy bit that I wanted to do
and d.product_name in ('FIRE','FIRE AND FUNERAL')
and a.snapshot_date_key= @date_key
#and DATE_ADD(a.suspension_date, INTERVAL 20 day) < '2021-05-31'
#group by b.mobile_number,a.policy_status_key 
;
# don't need to group by, you can just eyeball these


#clients in coverage. 
#You will then remove those that are in grace 1 2 and suspension mobiles list!!!
select a.customer_key, b.first_name, b.last_name, b.mobile_number
from Warehouse.fact_daily_policy_snapshot a
left join Warehouse.dim_customers b
on a.customer_key = b.customer_key
where a.policy_status_key = 2
#and mobile_number not in (0) #list of mobiles in grace 1 2 and suspension mobiles list!!!
and a.snapshot_date_key= @date_key
#group by b.mobile_number
;
#2507


select * from Warehouse.fact_daily_policy_snapshot limit 50