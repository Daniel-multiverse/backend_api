defmodule BackendApiWeb.AccountController do
  use BackendApiWeb, :controller
  alias BackendApiWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias BackendApi.Accounts
  alias BackendApi.Accounts.Account

  action_fallback BackendApiWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(account) do
      conn
      |> put_status(:created)
      |> render(:show, account: account)
      |> render("account_token.json", %{account: account, token: token})
    end
  end


  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> put_status(:ok)
        |> render("account_token.json", %{account: account, token: token})
      {:error, :unauthorised} -> raise ErrorResponse.Unauthorised, message: "Email or Password incorrect."
    end
  end


  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
