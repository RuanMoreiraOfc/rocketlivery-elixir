defmodule Rocketlivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum
  alias Rocketlivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [
    :category,
    :name,
    :description,
    :price,
    :photo
  ]
  @derive {Jason.Encoder, only: [:id] ++ @required_params}

  @category_enum [:food, :drink, :desert]

  schema "items" do
    many_to_many :orders, Order, join_through: "orders_items"

    field :category, Enum, values: @category_enum
    field :name, :string
    field :description, :string
    field :price, :decimal
    field :photo, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    # name
    |> unique_constraint([:name])
    # price
    |> validate_number(:price, greater_than: 0)

    # end_validation_pipe_line
  end
end
