local cmp = require("cmp")

vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
                cmp.setup.buffer({
                        enabled = false,
                })
        end,
})
