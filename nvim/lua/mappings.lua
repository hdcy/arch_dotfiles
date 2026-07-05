require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- H/L jump to line begin/end
map({ "n", "v" }, "H", "^", { desc = "Jump to line begin" })
map({ "n", "v" }, "L", "$", { desc = "Jump to line end" })

-- Space + w/q save/quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Space + f search
map("n", "<leader>f", "/", { desc = "Search in file" })

-- Alt + Space command panel
map({ "n", "i" }, "<M-Space>", "<cmd>Telescope commands<cr>", { desc = "Commands" })
