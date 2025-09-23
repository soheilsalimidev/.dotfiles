return {
  "stevearc/conform.nvim",
  formatters = {
      injected = { options = { ignore_errors = true } },
      dprint = {
        condition = function(ctx)
          return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier", stop_after_first = true, lsp_format = "fallback" },
      typescript = { "dprint" },
      javascriptreact = { "dprint" },
      typescriptreact = { "dprint" },
      svelte = { "dprint" },
      css = { "prettierd" },
      html = { "prettierd" },
      json = { "dprint" },
      yaml = { "dprint" },
      toml = { lsp_format = true },
      markdown = { "prettierd" },
      graphql = { "dprint" },
      liquid = { "prettier" },
      lua = { lsp_format = true },
      vue = { "dprint", "rustywind" },
      python = { "isort", "black" },
      prisma = { "prismals", lsp_format = "fallback" },
      rust = { "rustfmt", lsp_format = "fallback" },
      nix = { "nixfmt", lsp_format = "fallback" },
      sh = { "beautysh", lsp_format = "fallback" },
      sql = { "sql_formatter", prepend_args = { "-c", '{"keywordCase": "language"}' } },
    },
  },
}
