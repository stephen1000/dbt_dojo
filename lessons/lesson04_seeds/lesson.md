# Lesson 4- Seeds
Oftentimes, there are small tables in a warehouse that rarely change. dbt provides a framework for including this data in your source-controlled warehouse pipeline in the form of "Seeds".

In fact, the models we're using in this example are all sourced from seeds (you wouldn't want to do this to import actual data in production, but it's very convenient for this demo!)

## Create a new seed
You may have noticed that the customer model has a field for `country`, but it's only a 2 character code. We can define a table that maps that code to a country name using a seed:
- Copy `country_codes.csv` (from this directory) into `data/`
- Run `dbt seed` to deploy the seed
- Check out the new table (should be under `base_seeds.country_codes`)

## Use that seed to improve a model
Now that we have a mapping for country codes, let's add a `customer_country` view on our `customer` model. You can reference the seed like other models (using the `ref` function).

If you get stuck, you can look in `answers/customer_country.sql`.

## Use a seed to filter a model
Another use for seeds is identifying test accounts within your model. Create a seed called `test_customers.csv` in `data` with an `id` column and add a few customer ids to it. When you're done, deploy it by running `dbt seed` again.

Modify our `customer_payments` model in `reporting` to exclude the accounts identified in `test_customers`.

## Extra Credit
Try to refactor `payments` to use a foreign key to a `payment_types` seed, instead of including the values directly.