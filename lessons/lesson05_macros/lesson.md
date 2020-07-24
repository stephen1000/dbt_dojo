# Jinja & Macros
dbt leverages the powerful Jinja templating framework to enable many of the features you've used today (such as `ref`). You can use Jinja Macros in your templates to simplify your queries or remove boiler-plate code.
## Generate sql with a python expression
Jinja allows python expressions to be evaluated directly in templates. This can be handy for changing a query based on configuration settings:
``` sql
select
    id,
    {% if this.schema == 'reporting' %}
    'reporting' as source
    {% else %}
    'other' as source
    {% endif %}
```
This is useful in larger projects, or prototypes where configuration is still not finalized.
## Generate sql with a loop
SQL can often follow patterns, which can be verbose or tedious to write out. Consider the following switch statement:
``` sql
select
    order_id,
    case
        when payment_method = 'credit card' then sum(amount)
        when payment_method = 'debit card' then sum(amount)
        when payment_method = 'cash' then sum(amount)
        when payment_method = 'check' then sum(amount)
        when payment_method is null then 0
        else null end as payment_amount
from
    payments
```
For each payment_method, we have to write a whole line of code that's essentially the same every time. Using a loop, we can simplify this query to:
``` sql
{% set payment_methods = ["credit card", "debit card", "cash", "check"] %}
select
    order_id,
    case
        {% for payment_method in payment_methods %}
        when payment_method = '{{ payment_method }}' then sum(amount)
        {% endfor %}
        when payment_method is null then 0
        else null end as payment_amount
from
    payments
```
## Create a macro
Sometimes, we have a snippet of SQL that we want to reuse. Many database implementations offer stored functions that could be used to save that code, but the implementation is different, and can't viewed outside of the database. Using a custom macro, we can define a reusable piece of code that lives in the same repository as the rest of our warehouse pipeline.
Consider the `sum()` function in sql- by default, if all values passed to `sum()` are null, sum returns null. If we often need a different behavior- returning 0 if all values are null, we can define a macro to do so instead:
``` sql
{% macro sum_null_as_zero(column_name) %}
    sum(coalesce(column_name), 0)
{% endmacro %}
```
If we place that macro in `macros/sum_null_as_zero.sql`, we can use it in any of our models just like we use `ref`:
``` sql
select
    order_id,
    {{ sum_null_as_zero('amount')}}
from
    orders
```
Create a macro that trims whitespace on both sides of a string.
## Extra credit
Create a macro that takes a list of column names and writes a valid merge statement for two tables `target` and `source`.