defmodule Rocketlivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.ViaCep.{Client, Response}

  describe "get_cep_info/1" do
    setup do
      bypass = Bypass.open()
      base_url = "http://localhost:#{bypass.port}"

      {:ok, bypass: bypass, base_url: base_url}
    end

    test "returns cep info when `cep` is valid", %{bypass: bypass, base_url: base_url} do
      cep = "05030030"
      expect_body = ~s({
        "cep": "05030-030",
        "localidade": "São Paulo",
        "uf": "SP"
      })

      expect_response = {
        :ok,
        %Response{
          city: "São Paulo",
          uf: "SP"
        }
      }

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> Conn.put_resp_content_type("application/json")
        |> Conn.resp(200, expect_body)
      end)

      reponse = Client.get_cep_info(base_url, cep)

      assert reponse == expect_response
    end

    test "fails to return cep info when `cep` is invalid", %{
      bypass: bypass,
      base_url: base_url
    } do
      cep = "123"

      expect_response = {
        :error,
        %ErrorHelper{
          status: :bad_request,
          result: "Invalid CEP!"
        }
      }

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> Conn.resp(400, "")
      end)

      reponse = Client.get_cep_info(base_url, cep)

      assert reponse == expect_response
    end

    test "fails to return cep info when `cep` have not been found", %{
      bypass: bypass,
      base_url: base_url
    } do
      cep = "00000000"
      expect_body = ~s({
        "erro": "true"
      })

      expect_response = {
        :error,
        %ErrorHelper{
          status: :not_found,
          result: "CEP not found!"
        }
      }

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> Conn.put_resp_content_type("application/json")
        |> Conn.resp(200, expect_body)
      end)

      reponse = Client.get_cep_info(base_url, cep)

      assert reponse == expect_response
    end
  end
end
