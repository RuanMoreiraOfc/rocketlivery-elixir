defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Mox
  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.User
  alias Rocketlivery.Users.Create
  alias Rocketlivery.ViaCep.{ClientMock, Response}

  describe "call/1" do
    test "creates an user in database when all params are valid" do
      params = string_params_for(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        response = struct!(Response, build(:user_cep_info))

        {:ok, response}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id}} = response
    end

    test "fails to create an user in database when any param is invalid" do
      params = string_params_for(:user_params, age: 17)

      response = Create.call(params)

      assert {:error, %ErrorHelper{status: :bad_request, result: _result}} = response
    end
  end
end
