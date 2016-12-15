defmodule LegendaDahora.PageController do
  use LegendaDahora.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
