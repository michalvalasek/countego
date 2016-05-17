use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :count_ego, CountEgo.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :count_ego, CountEgo.Repo,
  adapter: Mongo.Ecto,
  database: "count_ego_test",
  pool_size: 1
