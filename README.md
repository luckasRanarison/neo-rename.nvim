# neo-rename.nvim

A simple plugin that adds [workspace/willRenameFiles](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#workspace_willRenameFiles) support for [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim).

## Installation

Works out of the box and asynchronous by default, no extra configuration needed.

Using [Lazy](https://github.com/folke/lazy.nvim):

```lua
return {
  "luckasRanarison/neo-rename.nvim",
  dependencies = { "nvim-neo-tree/neo-tree.nvim" },
  opts = {},
},
```

Using [Packer](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "luckasRanarison/neo-rename.nvim",
  requires = { "nvim-neo-tree/neo-tree.nvim" },
  config = function()
    require("neo-rename").setup()
  end
},
```
