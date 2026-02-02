defmodule DemoWeb.CrashLab.Guarded.CrashOnMountLive do
  use DemoWeb, :live_view
  use LiveRescue

  @impl true
  def mount(_params, _session, _socket) do
    raise "Simulated crash in Guarded.CrashOnMountLive.mount"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-base-100 shadow-sm border border-base-200">
      <div class="card-body">
        <h1 class="card-title text-success">Mount Succeeded!</h1>
        <p>The LiveView mounted successfully without crashing.</p>
        <a href="/guarded" class="btn btn-primary btn-sm mt-4">Back to Crash Lab</a>
      </div>
    </div>
    """
  end
end
