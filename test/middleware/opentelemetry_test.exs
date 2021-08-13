defmodule OpenTelemetryTesla.Middleware.OpenTelemetryTest do
  use ExUnit.Case

  defmodule Client do
    use Tesla

    plug(Tesla.Middleware.KeepRequest)
    plug(Tesla.Middleware.Telemetry, metadata: %{custom: "meta"})
    plug(Tesla.Middleware.PathParams)

    adapter(fn env ->
      case env.url do
        "/telemetry_error" -> {:error, :econnrefused}
        "/telemetry_exception" -> raise "some exception"
        "/telemetry" <> _ -> {:ok, env}
      end
    end)
  end

  setup do
    {:ok, _telemetry_app} = Application.ensure_all_started(:telemetry)
    {:ok, _telemetry_registry} = Application.ensure_all_started(:telemetry_registry)
    {:ok, _otel_telemetry_app} = Application.ensure_all_started(:opentelemetry_telemetry)
    {:ok, _otel_tesla} = Application.ensure_all_started(:opentelemetry_tesla)


    on_exit(fn ->
      :telemetry.list_handlers([])
      |> Enum.each(&:telemetry.detach(&1.id))
    end)

    :ok
  end


  test "events are all emitted properly" do
    Enum.each(["/telemetry", "/telemetry_error"], fn path ->
      Client.get(path)
    end)
  end
end
