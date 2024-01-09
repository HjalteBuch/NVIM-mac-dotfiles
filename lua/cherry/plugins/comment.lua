return {
    "numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true
}
-- Normal mode `gc` - Toggles the region using linewise comment
-- Visual mode `gcc` - Toggles the current line using linewise comment
