defmodule Rocketlivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rocketlivery.Helpers.Validators.Email, as: EmailValidatorHelper

  @primary_key {:id, :binary_id, autogenerate: true}
  @displyabale_params [
    :email,
    :name,
    :age,
    :cpf,
    :address,
    :cep
  ]
  @required_params [:password] ++ @displyabale_params
  @update_params [] ++ @displyabale_params
  @derive {Jason.Encoder, only: [:id] ++ @displyabale_params}

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :age, :integer
    field :cpf, :string
    field :address, :string
    field :cep, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> build_changeset(params, @required_params)
  end

  def changeset(struct, %{"password" => _password} = params) do
    struct
    |> build_changeset(params, @required_params)
  end

  def changeset(struct, params) do
    struct
    |> build_changeset(params, @update_params)
  end

  defp build_changeset(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    # email
    |> validate_format(:email, EmailValidatorHelper.regex())
    |> validate_length(:email, less_than_or_equal_to: 320)
    |> unique_constraint([:email])
    # password
    |> validate_length(:password, min: 8, max: 40)
    # age
    |> validate_number(:age, greater_than_or_equal_to: 18)
    # cpf
    |> validate_length(:cpf, is: 11)
    |> unique_constraint([:cpf])
    # cep
    |> validate_length(:cep, is: 8)
    # end_validation_pipe_line
    |> put_password_hash
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = old_changeset) do
    change(old_changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(old_changeset), do: old_changeset
end
