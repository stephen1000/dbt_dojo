{{ config(schema='reporting', materialized='table') }}

select
    o.id as order_id,
    o.customer_id as customer_id,
    o.item_price * o.quantity as order_total,
    coalesce(sum(p.amount), 0) as payment_total,
    o.item_price * o.quantity - coalesce(sum(p.amount),0) as amount_remaining
from
    {{ ref('orders') }} as o
    left join {{ ref('payments') }} as p
        on p.order_id = o.id
group by
    o.id,
    o.customer_id,
    o.item_price * o.quantity
