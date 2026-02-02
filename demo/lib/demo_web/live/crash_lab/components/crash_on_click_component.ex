defmodule DemoWeb.CrashLab.CrashOnClickComponent do
  use DemoWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :clicks, 0)}
  end

  @impl true
  def handle_event("crash", _params, _socket) do
    raise "Simulated crash in CrashOnClickComponent.handle_event"
  end

  def handle_event("safe_click", _params, socket) do
    {:noreply, assign(socket, :clicks, socket.assigns.clicks + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-warning/10 border border-warning/30">
      <div class="card-body p-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="font-medium">Click Counter: {@clicks}</p>
            <p class="text-xs text-base-content/60">Safe clicks work, crash button doesn't</p>
          </div>
          <div class="flex gap-2">
            <button phx-click="safe_click" phx-target={@myself} class="btn btn-success btn-sm">
              Safe Click
            </button>
            <button phx-click="crash" phx-target={@myself} class="btn btn-error btn-sm">
              Crash!
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
