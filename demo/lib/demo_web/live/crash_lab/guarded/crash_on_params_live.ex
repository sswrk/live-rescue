defmodule DemoWeb.CrashLab.Guarded.CrashOnParamsLive do
  use DemoWeb, :live_view
  use LiveRescue

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Params Crash Demo (LiveRescue)")
     |> assign(:guarded, true)}
  end

  @impl true
  def handle_params(%{"crash" => "true"}, _uri, _socket) do
    raise "Simulated crash in Guarded.CrashOnParamsLive.handle_params"
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-base-100 shadow-sm border border-base-200 max-w-md mx-auto mt-8">
      <div class="card-body">
        <h2 class="card-title">Params Crash Demo</h2>
        <div class="badge badge-success gap-1 mb-2">
          <.icon name="hero-shield-check-micro" class="size-3" /> LiveRescue Protected
        </div>
        <p class="text-base-content/60">
          This page crashes when navigated with <code>?crash=true</code> parameter.
        </p>
        <p class="text-success">You reached this page without the crash parameter!</p>
        <p class="text-xs text-base-content/50 mt-2">
          LiveRescue protects handle_params - the crash will be caught and the component will recover.
        </p>
        <div class="card-actions mt-4">
          <a href={~p"/guarded/crash/params?crash=true"} class="btn btn-error btn-sm">
            Crash Now
          </a>
          <a href={~p"/guarded"} class="btn btn-ghost btn-sm">
            Back to Crash Lab
          </a>
        </div>
      </div>
    </div>
    """
  end
end
