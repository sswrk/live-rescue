defmodule DemoWeb.CrashLab.Guarded.CrashOnRenderLive do
  use DemoWeb, :live_view
  use LiveRescue

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Render Crash Demo (LiveRescue)")
     |> assign(:guarded, true)}
  end

  @impl true
  def render(_assigns) do
    raise "Simulated crash in Guarded.CrashOnRenderLive.render"
  end
end
