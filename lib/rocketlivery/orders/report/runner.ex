defmodule Rocketlivery.Orders.Report.Runner do
  use GenServer

  require Logger

  alias Rocketlivery.Orders.Report.Create, as: ReportCreate

  # 5 hour
  @execution_interval 1000 * 60 * 60 * 5
  # 3 seg
  @message_interval 1000 * 3

  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  @impl true
  def init([env: :prod] = state) do
    schedule_report_generator(0)

    {:ok, state}
  end

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_info({:generate_setup, repeating?}, state) do
    if repeating? do
      Logger.info("Generating periodic report...")
    else
      Logger.info("Generating initial report...")
    end

    schedule(:generate, @message_interval)

    {:noreply, state}
  end

  def handle_info(:generate, state) do
    ReportCreate.call()
    schedule_report_generator()

    {:noreply, state}
  end

  defp schedule(message, interval) when is_integer(interval) do
    Process.send_after(self(), message, interval)
  end

  defp schedule_report_generator(interval \\ @execution_interval) do
    repeating? = interval == @execution_interval
    message = {:generate_setup, repeating?}

    schedule(message, interval)
  end
end
