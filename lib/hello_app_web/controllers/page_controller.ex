defmodule HelloAppWeb.PageController do
  use HelloAppWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def hello(conn, _params) do
    html(conn, "<h1>¡Chao bambino!</h1>")
  end

  def goodbye(conn, _params) do
    html(conn, "goodbye, world!")
  end
end
