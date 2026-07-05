local M = {}
M.logpath = vim.fn.stdpath("state") .. "/conform.log"
M.planned_names = {}
-- M.initial_lines = nil
-- M.will_use_lsp = nil
-- M.planned = nil
-- M.buf = nil

-- Return list of planned formatter names and whether LSP will be used
M.check_initial_logfile = function ()
  M.buf = 0
  -- ask Conform what it plans to run (deterministic, no race)
  M.planned, M.will_use_lsp = require("conform").list_formatters_to_run(M.buf)
  M.planned_names = {}
  if M.planned and M.planned[1] then
    for _, f in ipairs(M.planned[1]) do
      table.insert(M.planned_names, f.name)
    end
  end

  -- determine conform log path and initial line count
  if vim.fn.filereadable(M.logpath) == 1 then
    M.initial_lines = #vim.fn.readfile(M.logpath) or 0
  else
    M.initial_lines = 0
  end
end


function M.get_formatter(err, did_edit)
  if err then
    vim.notify("Conform error:" .. vim.inspect(err), vim.log.levels.ERROR)
    return
  end

  if not did_edit then
    vim.notify("No formatting completed.", vim.log.levels.WARNING)
    return
  end

  vim.defer_fn(function()
    if vim.fn.filereadable(M.logpath) ~= 1 then
      vim.notify("conform.log not present", vim.log.levels.WARNING)
      return
    end

    local all_lines = vim.fn.readfile(M.logpath)
    local new_lines = #all_lines
    if new_lines <= M.initial_lines then
      vim.notify("conform.log unchanged since formatting", vim.log.levels.WARNING)
      return
    end
    local start_idx = math.max(M.initial_lines + 1, new_lines - 50 + 1)
    local seen = {}
    local order = {}
    for i = start_idx, new_lines do
      local line = all_lines[i]
      local name = line:match('([%w_%-]+)%s+exited with code%s+0') or line:match('Run%s+([%w_%-]+)')
      if name and not seen[name] then
        seen[name] = true
        table.insert(order, name)
      end
    end

    if #order > 0 then
      if #order == 1 then
        vim.notify('File formatted with: ' .. order[1], vim.log.levels.INFO)
      else
        vim.notify('File formatted with: ' .. table.concat(order, ', '), vim.log.levels.INFO)
      end
      return
    end

    -- if no Run lines found, but Conform planned to use LSP, report available LSPs
    if M.will_use_lsp then
      local clients = vim.lsp.get_clients({ bufnr = M.buf })
      local names = {}
      for _, c in ipairs(clients) do
        if c.supports_method and (c:supports_method('textDocument/formatting') or c:supports_method('textDocument/rangeFormatting')) then
          table.insert(names, c.name)
        end
      end
      if #names > 0 then
        vim.notify('Formatted via LSP(s): ' .. table.concat(names, ', '), vim.log.levels.INFO)
      else
        vim.notify('No formatter detected (Conform planned LSP but no LSP reported formatting)')
      end
      return
    end

    -- otherwise, report planned candidates if any, else say nothing found
    if #M.planned_names > 0 then
      vim.notify('Planned formatters were: ' .. table.concat(M.planned_names, ', '), vim.log.levels.INFO)
    else
      vim.notify('No formatter lines detected in conform.log', vim.log.levels.INFO)
    end
  end, 300)
end

return M
