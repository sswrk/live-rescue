defmodule DemoWeb.CrashLab.Guarded.CrashOnUpdateComponent do
  use DemoWeb, :live_component
  use LiveRescue

  @impl true
  def update(%{value: value}, _socket) when value > 3 do
    raise "Simulated crash in Guarded.CrashOnUpdateComponent.update (value #{value} > 3)"
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-success/10 border border-success/30">
      <div class="card-body p-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="font-medium">Current Value: {@value}</p>
            <p class="text-xs text-base-content/60">
              Crashes when value > 3 (shows flash, keeps state)
            </p>
          </div>
          <div
            class="radial-progress text-success"
            style={"--value: #{min(@value * 25, 100)}; --size: 3rem;"}
          >
            {@value}
          </div>
        </div>
        <progress class="progress progress-success w-full" value={@value} max="4"></progress>
      </div>
    </div>
    """
  end
end
