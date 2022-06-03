defmodule Rocketlivery.ViaCep.Client do
  use Tesla

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.ViaCep.Response
  alias Tesla.Env

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def get_cep_info(cep) do
    "#{cep}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => "true"}}}) do
    Error.build_cep_not_found_error()
    |> Error.wrap()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"localidade" => city, "uf" => uf}}}) do
    response = Response.build(city, uf)

    {:ok, response}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    Error.build_cep_bad_request_error()
    |> Error.wrap()
  end

  defp handle_get({:error, reason}) do
    reason
    |> Error.build_bad_request()
    |> Error.wrap()
  end
end
