TERMINAL_BUFFER = nil
local switch_to_terminal = function()
        if TERMINAL_BUFFER == nil then
                vim.cmd(":terminal")
                TERMINAL_BUFFER = vim.fn.expand("%")
        else
                xpcall(function()
                        vim.cmd("b " .. TERMINAL_BUFFER)
                end, function(err)
                        print("error when opening old terminal buffer. Creating new buffer")
                        vim.cmd(":terminal")
                        TERMINAL_BUFFER = vim.fn.expand("%")
                end)
        end
end

vim.keymap.set("n", "<leader>r", function()
        switch_to_terminal()
        vim.api.nvim_command("startinsert")
end, { desc = "open terminal (insert mode)" })
vim.keymap.set("n", "<leader>R", function()
        switch_to_terminal()
end, { desc = "open terminal (normal mode)" })
