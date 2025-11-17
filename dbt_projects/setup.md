python3 -m venv dbt-env
source dbt-env/bin/activate

pip install dbt-snowflake
dbt init my_project_1

dbt run --select "path:models/staging"
dbt run --select path:models/intermediate

dbt run --select path:models/marts

dbt docs generate

dbt docs serve

ls ~/.dbt/