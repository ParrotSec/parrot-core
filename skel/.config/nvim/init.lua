-- Use the system-provided Gruvbox if available; otherwise keep the default theme.
vim.opt.termguicolors = true
vim.opt.background = "dark"
pcall(vim.cmd.colorscheme, "gruvbox")

-- Preserve the original Vim keys instead of Neovim's diagnostic mappings.
for _, key in ipairs({ "[d", "]d", "<C-w>d", "<C-w><C-d>" }) do
  pcall(vim.keymap.del, "n", key)
end

local function on_attach(_, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  vim.bo[bufnr].formatexpr = ""
  pcall(vim.keymap.del, "n", "K", { buffer = bufnr })
end

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.gopls.setup({ on_attach = on_attach })

if vim.fn.executable("pyright-langserver") == 1 then
  lspconfig.pyright.setup({ on_attach = on_attach })
end
if vim.fn.executable("typescript-language-server") == 1 then
  lspconfig.ts_ls.setup({ on_attach = on_attach })
end
if vim.fn.executable("kotlin-language-server") == 1 then
  lspconfig.kotlin_language_server.setup({ on_attach = on_attach })
end
if vim.fn.executable("OmniSharp") == 1 then
  lspconfig.omnisharp.setup({ on_attach = on_attach, cmd = { "OmniSharp" } })
end
if vim.fn.executable("jdtls") == 1 then
  lspconfig.jdtls.setup({
    on_attach = on_attach,
    on_new_config = function(config, root_dir)
      -- Give each Java project its own workspace and configuration directory.
      local cache = vim.fn.stdpath("cache") .. "/jdtls/"
        .. vim.fn.sha256(root_dir or vim.fn.getcwd())
      vim.fn.mkdir(cache, "p")
      config.cmd = {
        "jdtls", "-configuration", cache .. "/config", "-data", cache .. "/workspace",
      }
      config.init_options.workspace = cache .. "/workspace"
    end,
  })
end

vim.diagnostic.config({ virtual_text = false })
vim.g.gitgutter_map_keys = 0

-- Styled Vim tab pages: :tabedit, gt, gT, :tabclose. No new shortcuts or fonts.
require("bufferline").setup({
  options = {
    mode = "tabs",
    numbers = function(opts) return tostring(opts.ordinal) end,
    indicator = { style = "underline" },
    separator_style = { "|", "|" },
    modified_icon = "*",
    left_trunc_marker = "<",
    right_trunc_marker = ">",
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    close_command = false,
    right_mouse_command = false,
    middle_mouse_command = false,
    always_show_bufferline = true,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count) return "(" .. count .. ")" end,
  },
})

-- Bottom status line, matching the colorscheme without requiring a Nerd Font.
require("lualine").setup({
  options = {
    theme = "auto",
    icons_enabled = false,
    component_separators = "|",
    section_separators = "",
  },
})
