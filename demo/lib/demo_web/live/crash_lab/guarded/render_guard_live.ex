defmodule DemoWeb.CrashLab.Guarded.RenderGuardLive do
  @moduledoc """
  Demonstrates `<.eager_error_boundary>` for catching render errors.

  This LiveView uses `<.eager_error_boundary>` which eagerly evaluates the rendered
  struct and catches any errors in functional components.
  """
  use DemoWeb, :live_view
  use LiveRescue

  import DemoWeb.CrashLab.CrashingFunctional
  import LiveRescue, only: [eager_error_boundary: 1]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Render Guard Tests")
     |> assign(:show_crashing_component, false)
     |> assign(:counter, 0)}
  end

  @impl true
  def handle_event("toggle_crashing_component", _params, socket) do
    {:noreply, assign(socket, :show_crashing_component, !socket.assigns.show_crashing_component)}
  end

  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def handle_event("reset_counter", _params, socket) do
    {:noreply, assign(socket, :counter, 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-8">
      <div>
        <h1 class="text-2xl font-bold flex items-center gap-2">
          Render Guard Tests <span class="badge badge-success">LiveRescue Protected</span>
        </h1>
        <p class="text-base-content/60 mt-1">
          Testing <code>&lt;.eager_error_boundary&gt;</code>
          for catching errors in functional components during render.
        </p>
        <a href="/guarded" class="btn btn-ghost btn-sm mt-2">
          <.icon name="hero-arrow-left" class="size-4" /> Back to Crash Lab
        </a>
      </div>

      <%!-- <.eager_error_boundary> Section --%>
      <div class="card bg-base-100 shadow-sm border border-base-200">
        <div class="card-body">
          <h2 class="card-title text-lg flex items-center gap-2">
            <.icon name="hero-shield-exclamation" class="size-5 text-warning" />
            <code>&lt;.eager_error_boundary&gt;</code> Component Wrapper
          </h2>
          <p class="text-sm text-base-content/60 mb-4">
            The <code>&lt;.eager_error_boundary&gt;</code>
            component wraps specific parts of a template.
            Only the wrapped content shows error UI — the rest of the view continues to work.
          </p>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <h3 class="font-semibold">Guarded Crash</h3>
              <p class="text-sm text-base-content/60">
                This crashing component is wrapped in <code>&lt;.eager_error_boundary&gt;</code>.
                Only it shows the error UI.
              </p>
              <.eager_error_boundary>
                <.crash_on_render />
              </.eager_error_boundary>
            </div>

            <div class="space-y-2">
              <h3 class="font-semibold">Guarded Nested Crash</h3>
              <p class="text-sm text-base-content/60">
                A component that renders a crashing child, wrapped in <code>&lt;.eager_error_boundary&gt;</code>.
              </p>
              <.eager_error_boundary>
                <.nested_crash />
              </.eager_error_boundary>
            </div>

            <div class="space-y-2">
              <h3 class="font-semibold">Togglable Crashing Component</h3>
              <p class="text-sm text-base-content/60">
                Toggle to render a crashing component inside an <code>&lt;.eager_error_boundary&gt;</code>.
              </p>
              <button phx-click="toggle_crashing_component" class="btn btn-error btn-sm">
                <.icon name="hero-power" class="size-4" />
                {if @show_crashing_component, do: "Hide", else: "Show"} Crashing Component
              </button>
              <%= if @show_crashing_component do %>
                <.eager_error_boundary>
                  <.crash_on_render />
                </.eager_error_boundary>
              <% end %>
            </div>
          </div>
        </div>
      </div>

      <%!-- Reactivity Section --%>
      <div class="card bg-base-100 shadow-sm border border-base-200">
        <div class="card-body">
          <h2 class="card-title text-lg flex items-center gap-2">
            <.icon name="hero-arrow-path" class="size-5 text-primary" />
            Reactivity Inside the Boundary
          </h2>
          <p class="text-sm text-base-content/60 mb-4">
            Components inside <code>&lt;.eager_error_boundary&gt;</code> still re-render
            correctly when assigns change. The only difference is that every render sends
            a full update instead of a minimal diff.
          </p>

          <div class="flex items-center gap-4 mb-4">
            <button phx-click="increment" class="btn btn-primary btn-sm">
              <.icon name="hero-plus" class="size-4" /> Increment
            </button>
            <button phx-click="reset_counter" class="btn btn-ghost btn-sm">
              Reset
            </button>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="space-y-2">
              <h3 class="font-semibold">Outside boundary</h3>
              <p class="text-sm text-base-content/60">
                Normal rendering with change tracking.
              </p>
              <.counter_display count={@counter} />
            </div>

            <div class="space-y-2">
              <h3 class="font-semibold">Inside boundary</h3>
              <p class="text-sm text-base-content/60">
                Same component, same result, no change tracking.
              </p>
              <.eager_error_boundary>
                <.counter_display count={@counter} />
              </.eager_error_boundary>
            </div>

            <div class="space-y-2">
              <h3 class="font-semibold">Crashes above 5</h3>
              <p class="text-sm text-base-content/60">
                Works until count > 5, then shows error UI. Reset to recover.
              </p>
              <.eager_error_boundary>
                <.crash_above_threshold count={@counter} />
              </.eager_error_boundary>
            </div>
          </div>
        </div>
      </div>

      <%!-- Behavior Documentation --%>
      <div class="card bg-info/10 border border-info/20">
        <div class="card-body">
          <h2 class="card-title text-lg flex items-center gap-2">
            <.icon name="hero-information-circle" class="size-5 text-info" /> Expected Behavior
          </h2>
          <ul class="list-disc list-inside text-sm space-y-1 text-base-content/80">
            <li>
              <strong><code>&lt;.eager_error_boundary&gt;</code>:</strong>
              Only the wrapped content shows error UI; rest of the view is unaffected
            </li>
            <li>
              <strong>Trade-off:</strong> Disables LiveView change tracking for guarded content
            </li>
          </ul>
        </div>
      </div>
    </div>
    """
  end
end
