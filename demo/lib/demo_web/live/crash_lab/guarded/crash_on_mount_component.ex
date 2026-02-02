defmodule DemoWeb.CrashLab.Guarded.CrashOnMountComponent do
  use DemoWeb, :live_component
  use LiveRescue

  @impl true
  def mount(_socket) do
    raise "Simulated crash in Guarded.CrashOnMountComponent.mount"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="p-3 bg-success/10 border border-success/30 rounded-lg text-success">
      <p class="font-medium">Component mounted successfully!</p>
    </div>
    """
  end
end
