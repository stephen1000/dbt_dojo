# Lesson 1- Basics
We'll be confirming our project setup here.

## Install project
- Clone repo
- Create and activate a virtual environment
- Run `pip install -e .`

## Set up connection
To actually use dbt, setup a profile.yml to connect to a database of your choice- see `example_profiles.yml`.

Mac/Linux: place @ `~/.dbt/profiles.yml`

Windows: place @ `C:\Users\<username>\.dbt\profiles.yml`

## Update dbt_project.yml
Replace line 10 of `dbt_project.yml` with:

`profile: '<profile you created>'`