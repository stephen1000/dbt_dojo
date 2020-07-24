{{ config(schema='reporting', materialized='table') }}

select
    "TYPE" as payment_type,
    sum(amount) as payment_amount
from
    {{ ref('payments') }}
group by
    "TYPE"
