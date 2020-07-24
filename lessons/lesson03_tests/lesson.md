# Lesson 3- Tests
dbt provides several types of tests for the data in your warehouse. We'll be looking at applying some of these to our models.

## Adding tests
Look at the model definition `base/schema.yml`. Do you see where tests are being applied to columns in the model `customers`?

These tests are performed during the warehouse build and can alert you to potentially breaking issues with your data. For this lesson, we'll be writing tests for our other base models: `orders` and `payments`.

## Test Uniqueness
A common constraint in data warehouses is uniqueness. Some database implementations, however, don't have constructs for automatically enforcing this constraint. dbt has a test you can specify for this: `unique`.

To add a uniqueness test to a column, add a key for `tests` and an item for `unique` e.g.:
``` yml
...
columns:
  - name: some_column
    description: "description of some column"
    tests:
      - unique
...
```

Let's add uniqueness tests to the primary keys of `orders` and `payments`.

## Test Nullness
Another common requirement for data is that it's actually present-- i.e. not null. dbt provides a test for checking that no values are null: `not_null`.

Apply the `not_null` test to *each* column in `orders` and `payments`.

## Test Accepted Values
Sometimes a field should be set to one of a few different values (e.g. a status code). dbt has a test for that- `accepted_values`. To indicate a set of accepted values, add an object to `tests` with a key of `values` that points to a list of acceptable values:
``` yml
...
columns:
  - name: some_column
    description: "description of some column"
    tests:
      - accepted_values:
          values: ['cat', 'dog', 'fish']
...
```

Add a test for the `type` column in `payments` that accepts the following values:
- cash
- check
- credit card
- debit card

## Test Referential Integrity
Data Warehouses often make use of relationships between different models (hence the term "Relational Database"). Asserting that all foreign keys to another table actually exist during a warehouse build can save a lot of headache down the road. 

dbt's got you covered here as well, through the `relationships` test. You can check a column's referential integrity (whether each value in a column corresponds with an existing row in another table) by adding a relationship test:
``` yml
...
columns:
    - name: other_model_id
      description: Foreign Key to another model
      tests:
        - relationships:
            to: ref('other_model')
            field: 'id'
...
```

Add a relationship test to the foreign key fields in `orders` and `payments`.

## Extra Credit
Add appropriate tests to the models we made in `reporting`. Which tests are you adding and why?
