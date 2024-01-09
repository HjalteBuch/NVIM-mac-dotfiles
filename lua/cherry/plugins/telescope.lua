return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "sharkdp/fd",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "truncate " },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            pickers = {
                find_files = {
                    -- no_ignore = true
                },
                git_files = {
                    git_command = {'git', 'ls-files', '--cached', '--others'},
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness
        local builtin = require('telescope.builtin')

        keymap.set("n", "<leader>ff", builtin.find_files, {})
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {})
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", {})
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", {})
        keymap.set("n", "<leader>fg", builtin.git_files, {})
    end,
}
