defmodule DemoWeb.CrashLab.CrashOnUpdateComponent do
  use DemoWeb, :live_component

  @impl true
  def update(%{value: value}, _socket) when value > 3 do
    raise "Simulated crash in CrashOnUpdateComponent.update (value #{value} > 3)"
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-warning/10 border border-warning/30">
      <div class="card-body p-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="font-medium">Current Value: {@value}</p>
            <p class="text-xs text-base-content/60">Crashes when value exceeds 3</p>
          </div>
          <div
            class="radial-progress text-warning"
            style={"--value: #{min(@value * 25, 100)}; --size: 3rem;"}
          >
            {@value}
          </div>
        </div>
        <progress class="progress progress-warning w-full" value={@value} max="4"></progress>
      </div>
    </div>
    """
  end
end
