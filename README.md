# Temp-mark.nvim
> For when Ctrl-O spam is not enough

A simple plugin for creating a temporary mark that you can easily jump back to. 
It allows for quick navigation back to where you were when Ctrl-O would take too long or when `gi` would not work.

---

## Use Cases
- Jumping to edit a function that your code calls and then quickly returning back to where you were
- Decreasing your reliance on Ctrl-O
- Keeping you in the flow when editing ⚡

## Usage
To install this plugin with [lazy.nvim](https://github.com/folke/lazy.nvim), use:
```lua
{
	return "Justiniscoding/temp-mark.nvim",
	opts = {}
}
```

## Default configuration
The default configuration is as follows:
```lua
{
	-- The letter used when the plugin creates a mark.
	mark_letter = "M",

	-- Whether the plugin should show informational alerts. These are shown upon creating a mark and jumping back to one.
	show_alerts = false,

	-- Whether jumping back to a temporary mark should jump to the same column where the mark was made.
	return_to_mark_column = true,

	-- The keybinds for the plugin.
	keybinds = {
		-- The keybind for creating a temporary mark in normal mode.
		create_temp_mark = "mm",

		-- The keybind for jumping back to a temporary mark in normal mode.
		move_to_temp_mark = "Mm"
	}
}
```
**NOTE**: You do not need to supply the default configuration options for the plugin, only the values that you choose to change.
