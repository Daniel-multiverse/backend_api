defmodule BackendApiWeb.DefaultController do

  use BackendApiWeb, :controller

  def index(conn, _params)do
    text conn, "TEST"
  end

end
