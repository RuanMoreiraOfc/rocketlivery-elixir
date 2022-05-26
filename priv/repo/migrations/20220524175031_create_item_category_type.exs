defmodule Rocketlivery.Repo.Migrations.CreateItemCategoryType do
  use Ecto.Migration

  @categories [:food, :drink, :desert]
  @categories_as_string Enum.map_join(@categories, ", ", &"'#{&1}'")

  def change do
    up_query = "CREATE TYPE item_category AS ENUM (#{@categories_as_string})"
    down_query = "DROP TYPE item_category"

    execute(up_query, down_query)
  end
end
