local M = {}

-- Normalize path (remove "//", "~", etc.)
function M.norm(path)
  return vim.fs.normalize(path)
end

-- Detect project root using LSP or .git
function M.get_root()
  local buf = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(buf)
  if filename == '' then
    return vim.fn.getcwd()
  end

  -- 1. Try LSP root
  local clients = vim.lsp.get_clients { bufnr = buf }
  for _, client in ipairs(clients) do
    local root = client.config.root_dir
    if root and filename:find(root, 1, true) == 1 then
      return root
    end
  end

  -- 2. Try git root
  local gitdir = vim.fn.finddir('.git', filename .. ';')
  if gitdir ~= '' then
    return vim.fn.fnamemodify(gitdir, ':h')
  end

  -- 3. Fallback: CWD
  return vim.fn.getcwd()
end

-- Return cwd (always normalized)
function M.cwd()
  return M.norm(vim.fn.getcwd())
end

--@param opts {relative?: "cwd"|"root", modified_hl?: string, directory_hl?: string, filename_hl?: string, modified_sign?: string, readonly_icon?: string, length?: number}
function M.pretty_path(opts)
  opts = vim.tbl_extend('force', {
    relative = 'cwd',
    modified_hl = 'MatchParen',
    directory_hl = '',
    filename_hl = 'Bold',
    modified_sign = '',
    readonly_icon = ' 󰌾 ',
    length = 3,
  }, opts or {})

  return function()
    local path = vim.fn.expand '%:p'
    if path == '' then
      return ''
    end

    local root = M.get_root()
    local cwd = M.cwd()
    local norm = M.norm(path)

    -- Make path relative
    if opts.relative == 'cwd' and norm:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    elseif norm:find(root, 1, true) == 1 then
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, '[\\/]', { trimempty = true })

    -- Shorten
    if opts.length ~= 0 and #parts > opts.length then
      parts = { parts[1], '…', unpack(parts, #parts - opts.length + 2) }
    end

    -- Highlight filename separately
    local fname = parts[#parts]
    if vim.bo.modified then
      fname = fname .. opts.modified_sign
      fname = '%#' .. opts.modified_hl .. '#' .. fname .. '%*'
    else
      fname = '%#' .. opts.filename_hl .. '#' .. fname .. '%*'
    end

    -- Directory part
    local dir = ''
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep
      dir = '%#' .. opts.directory_hl .. '#' .. dir .. '%*'
    end

    local readonly = vim.bo.readonly and ('%#' .. opts.modified_hl .. '#' .. opts.readonly_icon .. '%*') or ''

    return dir .. fname .. readonly
  end
end

function M.root_dir(opts)
  opts = vim.tbl_extend('force', {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = '󱉭 ',
    color = { fg = '#efbe08' }, -- replace or remove
  }, opts or {})

  local function detect()
    local cwd = M.cwd()
    local root = M.get_root()
    local name = vim.fs.basename(root)

    if root == cwd then
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      return opts.parent and name
    else
      return opts.other and name
    end
  end

  local function component()
    local name = detect()
    if not name then
      return ''
    end
    return opts.icon .. ' ' .. name
  end

  return {
    component,
    cond = function()
      return detect() ~= nil
    end,
    color = opts.color,
  }
end

return M
