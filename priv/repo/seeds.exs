# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CountEgo.Repo.insert!(%CountEgo.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CountEgo.Repo
alias CountEgo.User

unless Repo.get_by(User, name: "Admin") do
  admin = Application.get_env(:count_ego, :admin_user)
  changeset = User.registration_changeset(%User{}, Enum.into(admin, %{}))
  case Repo.insert(changeset) do
    {:ok, user} ->
      IO.puts "User #{user.name} created..."
    {:error, changeset} ->
      IO.puts "Unable to create user..."
      IO.inspect changeset[:errors]
  end
end
