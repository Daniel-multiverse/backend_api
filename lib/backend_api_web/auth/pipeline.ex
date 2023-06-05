defmodule BackendApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :backend_api,
  module: BackendApiWeb.Auth.Guardian,
  error_handler: BackendApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

end
