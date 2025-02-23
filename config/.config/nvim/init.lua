--[[
     _       _ _     _
    (_)     (_) |   | |
     _ _ __  _| |_  | |_   _  __ _
    | | '_ \| | __| | | | | |/ _` |
    | | | | | | |_ _| | |_| | (_| |
    |_|_| |_|_|\__(_)_|\__,_|\__,_|

    Neovim configuration in Lua
--]]



-- [[ Setting options ]]
require 'core.options'


-- [[ Basic key mappings ]]
require 'core.keymaps'


-- [[ Custom Commands ]]
require 'core.commands'


-- [[ Basic Autocommands ]]
require 'core.autocmds'


-- [[ Plugins ]]

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require("lazy").setup({

    -- UI settings (status line and color theme)
    require 'plugins.ui',

    -- Fast fuzzy finder
    require 'plugins.fzf',

    -- Improves syntax coloring
    require 'plugins.treesitter',

    -- Contains miscellaneous small plugins
    require 'plugins.misc',

    -- Language Server Protocol
    require 'plugins.lsp',

})
