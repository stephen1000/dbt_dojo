
select
    *
from
    {{ source('base', 'order') }}
