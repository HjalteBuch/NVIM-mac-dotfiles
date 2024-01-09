vim.g.mapleader = " "

local keymap = vim.keymap 

keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlighting
keymap.set("n", "x", '"_x') -- delete single character without copying into register

-- Windows.. not really using
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

-- Move highlighting with shift J K
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center screen when scrolling up, down or finding next in search
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- close windows
keymap.set("n", "<C-x>", "<C-w>c")

-- Create new term in splitscreen
keymap.set("n", "<leader>t", ":sp | terminal<CR>i")
-- Use escape to go to normal mode in terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>")
