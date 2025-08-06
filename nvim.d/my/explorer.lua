-- ~/.config/nvim/nvim.d/my/explorer.lua
local ok_tree, nvim_tree = pcall(require, "nvim-tree")
if not ok_tree then return end

local ok_api, api = pcall(require, "nvim-tree.api")
if not ok_api then return end

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
local function on_attach(bufnr)
local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Close the tree
  vim.keymap.set("n", "<C-t>", api.tree.close, opts("Close"))

  -- Close parent directory
  vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Directory"))

  -- Open file or toggle dir; close the tree after opening a file
  local function open_under_cursor()
    local node = api.tree.get_node_under_cursor()
    if node and (node.type == "directory" or node.nodes ~= nil) then
      api.node.open.edit() -- expand/collapse directory
    else
      api.node.open.edit() -- open file in current window
      api.tree.close()
    end
  end

  vim.keymap.set("n", "<C-j>", open_under_cursor, opts("Toggle dir or open file"))
  vim.keymap.set("n", "o",     open_under_cursor, opts("Toggle dir or open file"))
end

nvim_tree.setup({
  on_attach = on_attach,
  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sort_by = "name",
  update_cwd = false, -- ok to keep; optional in newer releases
  view = {
    width = 100,
    side = "left",
    number = false,
    relativenumber = false,
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  diagnostics = {
    enable = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
})
