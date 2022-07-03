defmodule Rocketlivery.Orders.Report.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Orders.Report.Create

  defp ensure_there_is_no_file(filepath) do
    assert File.exists?(filepath) == false,
           """
           --- WARNING ---
           `#{filepath}` already exists, test failing to avoid override it!
           """
  end

  describe "call/1" do
    test "creates a report with database from database with default name" do
      file_path = "report.csv"

      insert(:order)

      expected_response = "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3,money,drink,Apple Juice,2.5,2.5\n"

      ensure_there_is_no_file(file_path)
      Create.call()

      response = File.read!(file_path)
      File.rm!(file_path)
      assert response == expected_response
    end
  end
end
