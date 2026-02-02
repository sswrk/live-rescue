defmodule DemoWeb.CrashLab.CrashOnRenderLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Render Crash Demo")}
  end

  @impl true
  def render(_assigns) do
    raise "Simulated crash in CrashOnRenderLive.render"
  end
end
