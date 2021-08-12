defmodule OpenTelemetryTesla.Registry do
  use TelemetryRegistry

  telemetry_event %{
    event: [:tesla, :request, :start],
    description: "Request starts in Tesla library",
    measurements: "%{system_time: non_neg_integer()}",
    metadata: "%{env: %Tesla.Env{url: String.t(), method: String.t()}"
  }

  telemetry_event %{
    event: [:tesla, :request, :stop],
    description: "Request stops in Tesla library",
    measurements: "%{duration: non_neg_integer()}",
    metadata: "%{env: %Tesla.Env{url: String.t(), method: String.t()}"
  }
end
