defmodule CountEgo.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller # we need the put_flash function etc.

  alias CountEgo.Repo
  alias CountEgo.User
  alias CountEgo.Router.Helpers

  def init(opts), do: opts

  # places User from session into conn.assigns
  # or keeps the one that's already there
  # or puts nil as :current_user
  # This will be called before EVERY action
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    cond do
      user = conn.assigns[:current_user] ->
        put_current_user(conn, user)

      user = user_id && Repo.get(User, user_id) ->
        put_current_user(conn, user)

      true ->
        assign(conn, :current_user, nil)
    end
  end

  def login(conn, user) do
    conn
    |> put_current_user(user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_password(conn, email, password) do
    user = Repo.get_by(User, email: email) # get user by email

    cond do
      user && checkpw(password, user.password_hash) ->
        # user exists and password is ok
        {:ok, login(conn, user)}

      user ->
        # user exists but password doesn't match
        {:error, :unauthorized, conn}

      true ->
        # user doesn't exist, let's just fake the password check
        dummy_checkpw() # protect against timing attacks
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
    # alternatively, if we wanted to keep the rest of the session:
    # delete_session(conn, :user_id)
  end


  # this works as a function plug
  # will be called only before actions that need to be authenticated
  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.front_path(conn, :index))
      |> halt()
    end
  end

  # Private

  defp put_current_user(conn, user) do
    #token = Phoenix.Token.sign(conn, "user socket", user.id)

    conn
    |> assign(:current_user, user)
    # |> assign(:user_token, token)
  end
end
