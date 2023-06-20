import Config

config :perf_analyzer,
  url: "http://httpbin.org/get",
  execution: %{
    execution_type: "sequential", # sequential, parallel
    steps: 5,
    increment: 1,
    duration: 2000,
    constant_load: false,
    dataset: "/Users/sample.csv",
    separator: ","
  },
  transactions: [
    %{
      name: "Transaction 1",
      timeout: 1000,
      request: %{
        method: "GET",
        path: "/endpoint1",
        headers: [{"Content-Type", "application/json"}],
        body: ""
      }
    },
    %{
      name: "Transaction 2",
      timeout: 100,
      request: %{
        method: "PUT",
        path: "/endpoint2",
        headers: [{"Content-Type", "application/json"}],
        body: ""
      }
    }
  ],
  distributed: :none,
  jmeter_report: true

config :logger,
  level: :info
