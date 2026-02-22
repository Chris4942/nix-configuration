require("conform").setup({
        formatters_by_ft = {
                lua = { "stylelua" },
                nix = { lsp_format = "fallback" },
        },
        format_on_save = { timeout_ms = 500 },
        default_format_opts = {},
});
