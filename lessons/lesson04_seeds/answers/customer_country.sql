
select
    cs.id,
    cs.first_name,
    cs.last_name,
    cs.birthday,
    cs.country as country_code,
    cc.country_name,
    cs.created_at
from
    {{ ref('customers') }} as cs
    left join {{ ref('country_codes') }} as cc
        on cc.country_code = cs.country
