defmodule DemoWeb.CrashLab.CrashOnParamsLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Params Crash Demo")}
  end

  @impl true
  def handle_params(%{"crash" => "true"}, _uri, _socket) do
    raise "Simulated crash in CrashOnParamsLive.handle_params"
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
        <p class="text-base-content/60">
          This page crashes when navigated with <code>?crash=true</code> parameter.
        </p>
        <p class="text-success">You reached this page without the crash parameter!</p>
        <div class="card-actions mt-4">
          <a href={~p"/crash/params?crash=true"} class="btn btn-error btn-sm">
            Crash Now
          </a>
          <a href={~p"/"} class="btn btn-ghost btn-sm">
            Back to Crash Lab
          </a>
        </div>
      </div>
    </div>
    """
  end
end
