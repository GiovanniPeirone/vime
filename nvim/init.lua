-- [[ Opciones básicas ]]
vim.opt.number = true            -- Números de línea
vim.opt.relativenumber = true    -- Números relativos
vim.opt.tabstop = 4              -- Tamaño del tabulador
vim.opt.shiftwidth = 4           -- Tamaño de la indentación
vim.opt.expandtab = true         -- Usa espacios en lugar de tabs
vim.opt.smartindent = true       -- Indentación inteligente
vim.opt.clipboard = "unnamedplus"
            

 -- [[ Plugins con lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    print("Error: No se pudo cargar lazy.nvim")
    return
end

lazy.setup({
    { "morhetz/gruvbox" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" }
}) 


-- [[ Configuración de LSP ]]
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

lspconfig.ts_ls.setup{ capabilities = capabilities, on_attach = on_attach }
lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }

-- Configuración de nvim-cmp para autocompletado
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
    })
})

-- [[ Configuración de lualine ]]
require("lualine").setup()

-- [[ Colorscheme ]]
vim.cmd("colorscheme gruvbox")

-- [[ Atajo de teclado para abrir el Explorer ]]
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>l", vim.cmd.Ex)

-- Abre un archivo en una nueva ventana verticalmente con <leader>v
vim.keymap.set("n", "<leader>v", ":vsplit<Space>", { noremap = true, silent = true })


