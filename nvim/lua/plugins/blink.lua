return {
  "saghen/blink.cmp",
  opts = {
    completion = { list = { selection = { preselect = true, auto_insert = false } } },
    keymap = {
      preset = "none",
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

      ["<Up>"] = { "scroll_documentation_up", "fallback" },
      ["<Down>"] = { "scroll_documentation_down", "fallback" },
      ["<Esc>"] = {
        function(cmp)
          if cmp.is_visible() then return end
          cmp.cancel()
        end,
        "fallback"
      }
    },
  },
}
