local M = {}

local events = require("neo-tree.events")
local subscribed = false

local function matches_filter(name, filter)
  local pattern = filter.pattern
  local regex_pattern = vim.fn.glob2regpat(pattern.glob)

  if pattern.options and pattern.options.ignorecase then regex_pattern = "\\c" .. regex_pattern end

  local regex = vim.regex(regex_pattern)

  return regex and regex:match_str(name) ~= nil
end

local function matches_filters(name, filters)
  local is_dir = vim.fn.isdirectory(name) == 1
  local type = is_dir and "folder" or "file"
  local matching_filters = vim.tbl_filter(function(filter)
    local matches = filter.pattern.matches
    return type == matches or not matches
  end, filters)

  if vim.tbl_isempty(matching_filters) then return true end

  for _, filter in pairs(matching_filters) do
    if matches_filter(name, filter) then return true end
  end

  return false
end

local function handler(args)
  local clients = vim.lsp.get_clients()
  local src = vim.fs.normalize(args.source)
  local dst = vim.fs.normalize(args.destination)

  for _, client in pairs(clients) do
    local reg_options =
      vim.tbl_get(client.server_capabilities or {}, "workspace", "fileOperations", "willRename")

    if reg_options and matches_filters(dst, reg_options.filters) then
      local params = {
        files = {
          {
            oldUri = "file://" .. src,
            newUri = "file://" .. dst,
          },
        },
      }

      ---@diagnostic disable-next-line: missing-parameter
      client.request("workspace/willRenameFiles", params, function(error, result)
        if error then
          local err_msg = type(error) == "string" and error or error.message
          vim.notify("[workspace/willRenameFiles] " .. err_msg, vim.log.levels.ERROR)
        end

        if result then vim.lsp.util.apply_workspace_edit(result, client.offset_encoding) end
      end)
    end
  end
end

M.setup = function()
  if not subscribed then
    events.subscribe({ event = events.FILE_RENAMED, handler = handler })
    events.subscribe({ event = events.FILE_MOVED, handler = handler })
    subscribed = true
  end
end

return M
