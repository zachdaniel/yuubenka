defmodule YuuWeb.PageController do
  use YuuWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
