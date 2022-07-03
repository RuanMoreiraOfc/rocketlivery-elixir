defmodule Rocketlivery.Users.UpdateTest do
  use Rocketlivery.DataCase, async: true

  import Mox
  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.User
  alias Rocketlivery.Users.Update
  alias Rocketlivery.ViaCep.ClientMock

  describe "call/1" do
    test "updates an user in database when all params are valid" do
      %{id: id} = insert(:user)
      new_params = %{"id" => id, "age" => 200}

      response = Update.call(new_params)

      assert {:ok, %User{id: ^id, age: 200}} = response
    end

    test "fails to update an user in database when any param is invalid" do
      %{id: id} = insert(:user)
      new_params = %{"id" => id, "age" => 17}

      response = Update.call(new_params)

      assert {:error,
              %ErrorHelper{
                status: :bad_request,
                result: %Changeset{errors: _errors}
              }} = response
    end

    test "fails to update an user in database when id is invalid" do
      %{id: id_from_database} = insert(:user)
      id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))
      new_params = %{"id" => id}

      response = Update.call(new_params)

      assert {:error, %ErrorHelper{status: :not_found, result: _result}} = response
    end

    test "fails to update an user in database when cep is invalid" do
      %{id: id} = insert(:user)
      new_params = %{"id" => id, "cep" => "00000000"}

      expected_response = {
        :error,
        %ErrorHelper{
          status: :not_found,
          result: %{
            message: "CEP not found!"
          }
        }
      }

      expect(ClientMock, :get_cep_info, fn _cep ->
        expected_response
      end)

      response = Update.call(new_params)

      assert ^expected_response = response
    end
  end
end
