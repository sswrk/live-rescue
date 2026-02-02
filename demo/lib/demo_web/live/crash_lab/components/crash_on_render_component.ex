defmodule DemoWeb.CrashLab.CrashOnRenderComponent do
  use DemoWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(_assigns) do
    raise "Simulated crash in CrashOnRenderComponent.render"
  end
end
