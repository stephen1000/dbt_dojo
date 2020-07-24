# Lesson 2- Models
Basics of working with dbt models

## Create some models
We're going to create some models for the reporting side of our warehouse.

- Copy the `reporting` directory from this folder into `models`
- Read the definitions of each model in `schema.yml`
- Using the model in `reporting/payment_types.sql` as a template, try to write models for `order_payments` and `customer_payments`


## Change model materialization
By default, all models are materialized as views. To create a table in a database, you can specify the materialization in the model's sql file by adding:
``` sql
{{ config(materialized='table') }}

select ...
```

Go ahead and change the materialization of each model in `reporting` to be a table!

## Create a table in a different schema
Another useful configuration option for models is `schema`, which determines which schema the materialization of your model will be placed in. Schema configuration can be set in a model's sql file by adding:

``` sql
{{ config(schema='some_schema') }}

select ...
```

Or, if you're setting materialization *and* schema:

``` sql
{{ config(schema='some_schema', materialized='table')}}
```

See if you can configure the models in `reporting` to land in a schema named "reporting"!

---

## Extra Credit
If you finish early, try one (or both!) of these:

### Default schemas

### Warehouse Tuning
Experiment with different materialization strategies- does `dbt` run faster with views, tables, temp tables, or even incremental loads?

See the [`dbt` documentation](https://docs.getdbt.com/docs/building-a-dbt-project/building-models/materializations) for help.
