defmodule Rocketlivery.Orders.Report.Create do
  import Ecto.Query
  alias Rocketlivery.{Item, Order, Repo}

  @default_block_size 500

  def call(filepath \\ "report.csv") do
    @default_block_size
    |> retrieve_data()
    |> write_file(filepath)
  end

  defp retrieve_data(max_rows) do
    query = from order in Order, order_by: order.user_id

    Repo.transaction(fn ->
      query
      |> Repo.stream(max_rows: max_rows)
      |> Stream.chunk_every(max_rows)
      |> Stream.flat_map(&Repo.preload(&1, :items))
      |> Enum.map(&parse_line/1)
    end)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map_join(items, ",", &parse_item/1)
    total_price = Enum.reduce(items, Decimal.new("0"), &reduce_item_price/2)

    "#{user_id},#{payment_method},#{items_string},#{total_price}\n"
  end

  defp parse_item(%Item{category: category, name: name, price: price}) do
    "#{category},#{name},#{price}"
  end

  defp reduce_item_price(%Item{price: price}, acc) do
    Decimal.add(acc, price)
  end

  defp write_file({_status, result}, filepath) do
    File.write(filepath, result)
  end
end
