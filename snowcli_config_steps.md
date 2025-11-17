# create virtual env
python3 -m venv venv
source venv/bin/activate

# install snow cli

pip install snowflake-cli

# setup snowconnection

mkdir -p ~/.snowflake
vi ~/.snowflake/config.toml
paste

[connections.default]
account = "<your_account>"
user = "<your_username>"
password = "<your_password>"
warehouse = "<warehouse>"
role = "<role>"
database = "<database>"
schema = "<schema>"

chmod 0600 ~/.snowflake/config.toml

snow connection test

# deploy snow dbt project
## change working directory to dbt project directoy
## inside run the command

snow dbt deploy my_cli_dbt_project



