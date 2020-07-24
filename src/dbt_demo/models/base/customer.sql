{{ config(materialized='table') }}

select
    *
from
    {{ source('base', 'customer') }}
