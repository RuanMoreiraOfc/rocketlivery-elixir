defmodule Rocketlivery.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users, type: :binary_id)
      add :address, :string
      add :payment_method, :payment_method
      add :notes, :string

      timestamps()
    end
  end
end
