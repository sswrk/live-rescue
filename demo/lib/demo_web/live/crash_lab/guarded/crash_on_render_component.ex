defmodule DemoWeb.CrashLab.Guarded.CrashOnRenderComponent do
  use DemoWeb, :live_component
  use LiveRescue

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(_assigns) do
    raise "Simulated crash in Guarded.CrashOnRenderComponent.render"
  end
end
