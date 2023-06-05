defmodule BackendApiWeb.Auth.ErrorResponse.Unauthorised do
  defexception [message: "Unauthorized", plug_status: 401]
end
