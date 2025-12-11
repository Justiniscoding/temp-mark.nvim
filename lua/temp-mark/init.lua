local M = {}

function M.setup(opts)
	-- Initialize the opts variable with the options passed
	-- by the plugin user in the setup function
	opts.mark_letter = opts.mark_letter or "M"
	opts.show_alerts = opts.show_alerts or false
	opts.return_to_mark_column = opts.return_to_mark_column or true

	opts.keybinds = opts.keybinds or { create_temp_mark = "mm", move_to_temp_mark = "Mm" }
	opts.keybinds.create_temp_mark = opts.keybinds.create_temp_mark or "mm"
	opts.keybinds.move_to_temp_mark = opts.keybinds.move_to_temp_mark or "Mm"

	-- Initialize a keymap for normal mode when "mm" is pressed
	-- This creates the temporary mark.
	vim.keymap.set("n", opts.keybinds.create_temp_mark, function()
		-- Get the id of the currently focused buffer
		local current_buffer = vim.api.nvim_get_current_buf()

		-- Get the current position of the cursor for creating the mark
		local cursor_position = vim.api.nvim_win_get_cursor(0)

		vim.api.nvim_buf_set_mark(current_buffer, opts.mark_letter, cursor_position[1], cursor_position[2], {})

		if opts.show_alerts then
			print("temp-mark.nvim: Temp mark created on line " .. cursor_position[1])
		end
	end)

	-- Initialize a keymap for normal mode when Mm is pressed
	-- This moves back to the temporary mark and deletes it.
	vim.keymap.set("n", opts.keybinds.move_to_temp_mark, function()
		-- Get the position of the temporary mark
		local markPosition = vim.api.nvim_get_mark(opts.mark_letter, {})

		-- Throw an error if the mark does not exist
		if markPosition[1] == 0 and markPosition[2] == 0 then
			error("temp-mark.nvim: No temporary mark found to return to!", 1)
		end

		-- If the return_to_mark_column option is set to false, set the
		-- position to jump back to to 0 (start of the column)
		if opts.return_to_mark_column == false then
			markPosition[2] = 0
		end

		-- Switch the open buffer to the buffer of the mark
		vim.api.nvim_set_current_buf(markPosition[3])

		-- Move the cursor back to the position of the mark
		vim.api.nvim_win_set_cursor(0, { markPosition[1], markPosition[2] })

		-- Delete the temporary mark
		vim.api.nvim_del_mark(opts.mark_letter)

		if opts.show_alerts then
			print("temp-mark.nvim: Returned to temporary mark")
		end
	end)
end

return M
