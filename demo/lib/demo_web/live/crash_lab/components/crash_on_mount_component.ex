defmodule DemoWeb.CrashLab.CrashOnMountComponent do
  use DemoWeb, :live_component

  @impl true
  def mount(_socket) do
    raise "Simulated crash in CrashOnMountComponent.mount"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>This will never render</div>
    """
  end
end
