defmodule Rocketlivery.Users.Update do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.Helpers.MergeChangeset, as: MergeChangesetHelper
  alias Rocketlivery.Helpers.MockUserParams, as: MockUserParamsHelper
  alias Rocketlivery.{Repo, User}
  alias Rocketlivery.ViaCep.Response

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil ->
        ErrorHelper.build_user_not_found_error()
        |> ErrorHelper.wrap()

      user ->
        do_update(user, params)
    end
  end

  defp do_update(user, params) do
    new_changeset =
      User.changeset(
        user,
        MockUserParamsHelper.call(params)
      )

    with(
      {:ok, %User{cep: cep}} <- User.validate(new_changeset, :update),
      {:ok, %Response{} = cep_info} <- update_cep_info(cep, user),
      {:ok, _user} = result <-
        new_changeset
        |> MergeChangesetHelper.call(cep_info)
        |> Repo.update()
    ) do
      result
    else
      {:error, %ErrorHelper{}} = error ->
        error

      {:error, reason} ->
        reason
        |> ErrorHelper.build_bad_request()
        |> ErrorHelper.wrap()
    end
  end

  defp update_cep_info(cep, user) when user.cep != cep do
    client().get_cep_info(cep)
  end

  defp update_cep_info(_cep, user) do
    result = Response.build(user.city, user.uf)
    {:ok, result}
  end

  defp client do
    :rocketlivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end
end
