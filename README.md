# neo-rename.nvim

A simple plugin that adds [workspace/willRenameFiles](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#workspace_willRenameFiles) support for [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim), it's basically a rewrite of [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations) adapted to my needs, and it fixes some of nvim-lsp-file-operations issues. I'll eventually port the changes there.

## Usage

The recommended way to use the plugin is by setting it as neo-tree dependency and calling the `setup()` function when initializing neo-tree for lazy loading. The plugin works out of the box, is asynchronous by default, and requires no additional configuration.

Example using [Lazy](https://github.com/folke/lazy.nvim):

```lua
return  {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    -- ...
    "luckasRanarison/neo-rename.nvim"
  },
  opts = {
    -- ...
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    require("neo-rename").setup()
  end
}
```
