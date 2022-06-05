import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rocketlivery, Rocketlivery.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "rocketlivery_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rocketlivery, RocketliveryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jpy3111jBF4nxyG+kbhzGEp2I4MU0BBC4eGwLkErVm4bwMYF7XVmQfUabGmjR+YI",
  server: false

# In test we don't send emails.
config :rocketlivery, Rocketlivery.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# External Libs
## Pbkdf2
config :pbkdf2_elixir, :rounds, 1

## Bypass
config :bypass, enable_debug_log: true
