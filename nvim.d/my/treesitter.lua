-- ~/.config/nvim/nvim.d/my/treesitter.lua
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  -- Only install what is necessary
  ensure_installed = {
    "lua", "vim", "vimdoc", "query",
    "bash",
    "python",
    "json", "yaml", "toml",
    "html", "css",
    "javascript", "typescript", "tsx",
    "regex",
    "markdown", "markdown_inline",
    "dockerfile",
    "gitcommit", "gitignore",
  },

  ignore_install = {},
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

  indent = {
    enable = true,
    disable = { "javascript" }, -- keep  original note
  },

  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
})
