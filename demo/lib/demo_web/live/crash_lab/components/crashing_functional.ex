defmodule DemoWeb.CrashLab.CrashingFunctional do
  @moduledoc """
  Functional components that crash during render, for testing render guards.
  """
  use Phoenix.Component

  def greeting(assigns) do
    ~H"""
    <div class="p-3 bg-success/10 rounded-lg">
      <strong>Hello!</strong> This component renders fine.
    </div>
    """
  end

  def crash_on_render(assigns) do
    raise "Simulated crash in CrashingFunctional.crash_on_render"

    ~H"""
    <div>This will never render</div>
    """
  end

  attr :count, :integer, required: true

  def counter_display(assigns) do
    ~H"""
    <div class="p-3 bg-primary/10 rounded-lg flex items-center gap-3">
      <span class="text-3xl font-bold text-primary">{@count}</span>
      <span class="text-sm text-base-content/60">clicks</span>
    </div>
    """
  end

  attr :count, :integer, required: true

  def crash_above_threshold(assigns) do
    if assigns.count > 5 do
      raise "Simulated crash: count #{assigns.count} exceeded threshold of 5"
    end

    ~H"""
    <div class="p-3 bg-warning/10 rounded-lg flex items-center gap-3">
      <span class="text-3xl font-bold text-warning">{@count}</span>
      <span class="text-sm text-base-content/60">clicks (crashes above 5)</span>
    </div>
    """
  end

  def nested_crash(assigns) do
    ~H"""
    <div class="p-3 bg-base-200 rounded-lg space-y-2">
      <strong>Nested wrapper</strong>
      <.crash_on_render />
    </div>
    """
  end
end
