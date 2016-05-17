defmodule CountEgo.SessionController do
  use CountEgo.Web, :controller

  def new(%{assigns: %{current_user: _current_user}} = conn) do
    conn
    |> put_flash(:info, "You're already logged in.")
    |> redirect(to: admin_path(conn, :index))
  end
  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case CountEgo.Auth.login_by_email_and_password(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: admin_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination.")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> CountEgo.Auth.logout
    |> put_flash(:info, "Logged out.")
    |> redirect(to: session_path(conn, :new))
  end
end
