defmodule Rocketlivery.Users.Create do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.Helpers.MergeChangeset, as: MergeChangesetHelper
  alias Rocketlivery.Helpers.MockUserParams, as: MockUserParamsHelper
  alias Rocketlivery.{Repo, User}
  alias Rocketlivery.ViaCep.{Client, Response}

  def call(params) do
    partial_changeset =
      params
      |> MockUserParamsHelper.call()
      |> User.changeset()

    with(
      {:ok, %User{cep: cep}} <- User.validate(partial_changeset, :create),
      {:ok, %Response{} = cep_info} <- Client.get_cep_info(cep),
      {:ok, _user} = result <-
        partial_changeset
        |> MergeChangesetHelper.call(cep_info)
        |> Repo.insert()
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
end
