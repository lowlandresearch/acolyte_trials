defmodule AcolyteTrialsWeb.PageController do
  use AcolyteTrialsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
