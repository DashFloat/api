defmodule DashFloatWeb.DummyController do
  use DashFloatWeb, :controller

  def index(conn, _params) do
    send_resp(conn, :no_content, "")
  end
end
