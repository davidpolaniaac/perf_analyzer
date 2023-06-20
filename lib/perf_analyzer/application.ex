defmodule PerfAnalyzer.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    IO.puts("Start")

    options = OptionParser.parse(args, switches: [config: :string])
    #config_file = options[:config]
    #path = options[:path]
    IO.inspect(options)
    #IO.puts("Configuration file: #{config_file}")
    #IO.puts("Path file: #{path}")

    {:ok, pid} = PerfAnalyzer.start_link()
    GenServer.call(pid, :execute)
    IO.puts("End")
    {:ok, pid}
  end
end
