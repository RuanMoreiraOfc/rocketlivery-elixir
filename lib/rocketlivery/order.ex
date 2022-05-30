defmodule Rocketlivery.Order do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum
  alias Rocketlivery.{Item, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [
    :user_id,
    :address,
    :payment_method,
    :notes
  ]
  @derive {Jason.Encoder, only: [:id, :items] ++ @required_params}

  @payment_method_enum [:money, :credit_card, :debit_card]

  schema "orders" do
    many_to_many :items, Item, join_through: "orders_items", on_delete: :delete_all

    belongs_to :user, User
    field :address, :string
    field :payment_method, Enum, values: @payment_method_enum
    field :notes, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:items, items)

    # end_validation_pipe_line
  end
end
