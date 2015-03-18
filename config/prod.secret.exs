use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :copysshow, Copysshow.Endpoint,
  secret_key_base: "X84L/KX0G7AkwBMEsnvU03JYM6uDgKN2oVVZPCf+EbuYvCPFSMYzpvgjghTN3v4n"

# Configure your database
config :copysshow, Copysshow.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "copysshow_prod"
