defmodule PerfAnalyzer do

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    #config = Application.get_env(:perf_analyzer, :execution)
    { :ok, config } = FileConfig.parse_file("./config.hcl")
    #IO.inspect(config[:config][:perf_analyzer])
    {:ok, config[:config]}
  end

  def handle_call(:execute, _from, config) do
    logic_request(config)
    {:reply, config, config}
  end

  def logic_request(config) do
    IO.puts(
      "configuration:"
    )
    IO.inspect(config["perf_analyzer"])
    data = config["perf_analyzer"]
    #transactions =  Application.get_env(:perf_analyzer, :transactions)
    #execution_type = config[:execution_type]
    transactions =  data[:transactions]
    execution_type = data[:execution][:execution_type]

    case execution_type do
      "sequential" -> execute_transactions_sequentially(transactions)
      "parallel" -> execute_transactions_in_parallel(transactions)
      _ -> IO.puts("Invalid execution type")
    end
  end

  def execute_transactions_sequentially([]), do: :ok
  def execute_transactions_sequentially([transaction | rest]) do
    execute_transaction(transaction)
    execute_transactions_sequentially(rest)
  end

  def execute_transactions_in_parallel(transactions) do
    transactions
    |> Enum.map(&(Task.async(fn -> execute_transaction(&1) end)))
    |> Enum.map(&Task.await/1)
  end

  def execute_transaction(transaction) do
    time = String.to_integer(transaction[:timeout])
    :timer.sleep(time)
    IO.puts("The timeout was #{time} milliseconds.")
    IO.puts("Executing transaction: #{transaction[:name]}")
    #response = HTTPoison.request(transaction[:request][:method], transaction[:request][:path], headers: transaction[:request][:headers], body: transaction[:request][:body].())
    #IO.inspect(response)
  end
end
