defmodule LvToastWeb.PageController do
  use LvToastWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
