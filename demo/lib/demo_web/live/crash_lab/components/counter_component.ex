defmodule DemoWeb.CrashLab.CounterComponent do
  use DemoWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :count, 0)}
  end

  @impl true
  def update(%{initial: initial} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:count, socket.assigns[:count] || initial)}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end

  def handle_event("decrement", _params, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count - 1)}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign(socket, :count, 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="card bg-success/10 border border-success/30">
      <div class="card-body p-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="font-medium">Counter: {@count}</p>
            <p class="text-xs text-base-content/60">A working component for comparison</p>
          </div>
          <div class="flex gap-1">
            <button phx-click="decrement" phx-target={@myself} class="btn btn-circle btn-sm">
              <.icon name="hero-minus-micro" class="size-4" />
            </button>
            <button
              phx-click="increment"
              phx-target={@myself}
              class="btn btn-circle btn-sm btn-success"
            >
              <.icon name="hero-plus-micro" class="size-4" />
            </button>
            <button phx-click="reset" phx-target={@myself} class="btn btn-circle btn-sm btn-ghost">
              <.icon name="hero-arrow-path-micro" class="size-4" />
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
