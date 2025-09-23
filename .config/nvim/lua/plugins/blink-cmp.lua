return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      ghost_text = {
        enabled = true,
      },
    },
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ['<CR>'] = { 'accept', 'fallback' },
    },
  }
}
