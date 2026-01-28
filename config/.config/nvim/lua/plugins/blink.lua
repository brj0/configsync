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

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = false } },

            signature = { enabled = true },

            sources = {
                default = { "path", "snippets", "buffer", "lazydev", "lsp" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                        async = true,
                    },
                    buffer = { async = false },
                    snippets = { async = false },
                    path = { async = false },
                    lsp = { async = true },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },

        opts_extend = { "sources.default" },
    },
}
