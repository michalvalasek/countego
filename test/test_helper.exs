ExUnit.start

Mix.Task.run "ecto.create", ~w(-r CountEgo.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r CountEgo.Repo --quiet)


