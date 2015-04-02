use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :restapp, Restapp.Endpoint,
  secret_key_base: "eJdAatFxrK2NJ+et/JD7zP0h3aEA6cQh5XStYt4x9sk0JtzrHvMupVgDkRcUIMKk"

# Configure your database
config :restapp, Restapp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "restapp_prod"
