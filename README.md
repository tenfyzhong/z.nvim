# z.nvim
A plugin to use `https://github.com/agkozak/zsh-z` in nvim.

# Install
requires: [junegunn/fzf](https://github.com/junegunn/fzf)  
Use Packer.nvim or the package management you link.  
Packer.nvim Example: 
```
use {
    'tenfyzhong/z.nvim',
    requires = 'junegunn/fzf',
    config = function()
        require('z').setup {}

        vim.keymap.set('n', '<leader>fz', ':FZFZ<cr>', { silent = true, remap = false })
        local group = vim.api.nvim_create_augroup('z_local', {})
        vim.api.nvim_create_autocmd('User', {
            group = group,
            pattern = 'Zcd',
            callback = function() require('feature').DefxCwd() end,
        })
    end,
}
```

# Setup

```
require('z').setup{}
```

# Usage
The plugin provide a command `FZFZ`, it will run `z` in fzf window.  
It will `doautocmd User Zcd` after cd to the path.
