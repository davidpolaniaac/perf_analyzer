defmodule Demo do
  def start() do
    {:ok, _pid} = PerfAnalyzer.start_link()
    #GenServer.call(_pid, :execute)
    :ok
  end
end
