return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        opts = {
            keymap = {
                preset = "default",
                ["<C-j>"] = { "accept" },
            },

            cmdline = {
                keymap = { preset = 'inherit' },
                completion = { menu = { auto_show = true } },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = false } },

            signature = { enabled = true },

            sources = {
                default = { "path", "snippets", "buffer", "lsp" },
                providers = {
                    buffer = { async = false },
                    snippets = { async = false },
                    path = { async = false },
                    lsp = { async = true },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },

        opts_extend = { "sources.default" },
    },
}
