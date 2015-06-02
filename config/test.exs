use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :restapp, Restapp.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :restapp, Restapp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rest",
  size: 1 # Use a single connection for transactional tests

config :joken,
  secret_key: "test",
  algorithm: :HS256,
  json_module: JWT.Module

config :login,
  username: "user",
  password: "password"