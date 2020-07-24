{{ config(materialized='table') }}

select
    *
from
    {{ ref('payment_data') }}
