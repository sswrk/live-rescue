defmodule DemoWeb.CrashLab.CrashOnInfoLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 1000)
      Process.send_after(self(), :crash_now, 2000)
    end

    {:ok,
     socket
     |> assign(:page_title, "Delayed Crash Demo")
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
    raise "Simulated crash in CrashOnInfoLive.handle_info after delay"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-base-100 shadow-sm border border-base-200 max-w-md mx-auto mt-8">
      <div class="card-body text-center">
        <h2 class="card-title justify-center">Delayed Crash Demo</h2>
        <p class="text-base-content/60">
          This page will crash in a moment when it receives a delayed message...
        </p>
        <div class="my-8">
          <span class="countdown font-mono text-6xl text-error">
            <span style={"--value: #{@countdown}"}></span>
          </span>
        </div>
        <div class="flex items-center justify-center gap-2 text-warning">
          <.icon name="hero-exclamation-triangle" class="size-5" />
          <span>Crash imminent!</span>
        </div>
        <div class="card-actions justify-center mt-4">
          <a href={~p"/"} class="btn btn-ghost btn-sm">
            Escape! Back to Crash Lab
          </a>
        </div>
      </div>
    </div>
    """
  end
end
