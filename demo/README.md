# LiveRescue Demo

An interactive demo app to explore how LiveRescue protects Phoenix LiveView from crashes.

## What It Does

The demo provides a "Crash Lab" with buttons that intentionally trigger crashes in various LiveView and LiveComponent callbacks. You can compare the behavior side-by-side:

| Route | Protection | Crash Behavior |
|-------|------------|----------------|
| `/` | None (standard Phoenix) | Process crashes, page reloads |
| `/guarded` | LiveRescue enabled | Error caught, flash message shown |

## Crash Scenarios

The demo covers crashes in all protected callbacks:

**LiveView crashes:**
- `mount/3` - Navigate to a page that crashes on mount
- `handle_event/3` - Click a button that raises an exception
- `handle_params/3` - Navigate with query params that cause a crash
- `handle_info/2` - Trigger a delayed message that crashes

**LiveComponent crashes:**
- `mount/1` - Toggle a component that crashes on mount
- `update/2` - Increment a value until the component crashes
- `handle_event/3` - Click a button inside a component
- `render/1` - Toggle a component that crashes during render

## Running the Demo

```bash
cd demo
mix setup
mix phx.server
```

Visit [localhost:4000](http://localhost:4000) to see standard Phoenix behavior, then [localhost:4000/guarded](http://localhost:4000/guarded) to see LiveRescue protection in action.
