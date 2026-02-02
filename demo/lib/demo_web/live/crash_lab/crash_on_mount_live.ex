defmodule DemoWeb.CrashLab.CrashOnMountLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, _socket) do
    raise "Simulated crash in CrashOnMountLive.mount"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>This will never render</div>
    """
  end
end
