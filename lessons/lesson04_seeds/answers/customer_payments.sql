{{ config(schema='reporting', materialized='table') }}

select
    c.id as customer_id,
    concat(c.first_name, ' ', c.last_name) as customer_name,
    sum(op.order_total) as total_owed,
    sum(op.payment_total) as total_paid,
    sum(op.order_total) - sum(op.payment_total) as account_balance
from
    {{ ref('customers') }} as c
    left join {{ ref('order_payments') }} as op
        on op.customer_id = c.id
    left outer join {{ ref('test_customers') }} as tc
        on tc.id = c.id
where
    tc.id is null
group by
    c.id,
    concat(c.first_name, ' ', c.last_name)