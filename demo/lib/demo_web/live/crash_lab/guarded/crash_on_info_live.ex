defmodule DemoWeb.CrashLab.Guarded.CrashOnInfoLive do
  use DemoWeb, :live_view
  use LiveRescue

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 1000)
      Process.send_after(self(), :crash_now, 2000)
    end

    {:ok,
     socket
     |> assign(:page_title, "Delayed Crash Demo (LiveRescue)")
     |> assign(:guarded, true)
     |> assign(:countdown, 2)}
  end

  @impl true
  def handle_info(:tick, socket) do
    new_countdown = socket.assigns.countdown - 1

    if new_countdown > 0 do
      Process.send_after(self(), :tick, 1000)
      {:noreply, assign(socket, :countdown, new_countdown)}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_info(:crash_now, _socket) do
    raise "Simulated crash in Guarded.CrashOnInfoLive.handle_info after delay"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-base-100 shadow-sm border border-base-200 max-w-md mx-auto mt-8">
      <div class="card-body text-center">
        <h2 class="card-title justify-center">Delayed Crash Demo</h2>
        <div class="badge badge-success gap-1 mx-auto mb-2">
          <.icon name="hero-shield-check-micro" class="size-3" /> LiveRescue Protected
        </div>
        <p class="text-base-content/60">
          This page will attempt to crash in a moment when it receives a delayed message...
        </p>
        <div class="my-8">
          <span class="countdown font-mono text-6xl text-success">
            <span style={"--value: #{@countdown}"}></span>
          </span>
        </div>
        <div class="flex items-center justify-center gap-2 text-success">
          <.icon name="hero-shield-check" class="size-5" />
          <span>LiveRescue will protect!</span>
        </div>
        <p class="text-xs text-base-content/50 mt-2">
          LiveRescue protects handle_info - the crash will be caught and the view will survive.
        </p>
        <div class="card-actions justify-center mt-4">
          <a href={~p"/guarded"} class="btn btn-ghost btn-sm">
            Back to Crash Lab
          </a>
        </div>
      </div>
    </div>
    """
  end
end
