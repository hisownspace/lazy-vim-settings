-- local logpath = vim.fn.stdpath("state") .. "/conform.log"
-- local planned_names = {}
-- local initial_lines
-- local will_use_lsp
-- local planned
-- local buf
--
-- local check_initial_logfile = function()
--   buf = 0
--   -- ask Conform what it plans to run (deterministic, no race)
--   planned, will_use_lsp = require("conform").list_formatters_to_run(buf)
--   planned_names = {}
--   if planned and planned[1] then
--     for _, f in ipairs(planned[1]) do
--       table.insert(planned_names, f.name)
--     end
--   end
--
--   -- determine conform log path and initial line count
--   if vim.fn.filereadable(logpath) == 1 then
--     initial_lines = #vim.fn.readfile(logpath) or 0
--   else
--     initial_lines = 0
--   end
-- end
--
-- local get_formatter = function(err, did_edit)
--   if err then
--     print("Conform error:", vim.inspect(err))
--     return
--   end
--
--   if not did_edit then
--     print("No formatting completed.")
--     return
--   end
--
--   vim.defer_fn(function()
--     if vim.fn.filereadable(logpath) ~= 1 then
--       print("conform.log not present")
--       return
--     end
--
--     local all_lines = vim.fn.readfile(logpath)
--     local new_lines = #all_lines
--     if new_lines <= initial_lines then
--       print("conform.log unchanged since formatting")
--       return
--     end
--     local start_idx = math.max(initial_lines + 1, new_lines - 50 + 1)
--     local seen = {}
--     local order = {}
--     for i = start_idx, new_lines do
--       local line = all_lines[i]
--       local name = line:match('([%w_%-]+)%s+exited with code%s+0') or line:match('Run%s+([%w_%-]+)')
--       if name and not seen[name] then
--         seen[name] = true
--         table.insert(order, name)
--       end
--     end
--
--     if #order > 0 then
--       if #order == 1 then
--         print('File formatted with: ' .. order[1])
--       else
--         print('File formatted with: ' .. table.concat(order, ', '))
--       end
--       return
--     end
--
--     -- if no Run lines found, but Conform planned to use LSP, report available LSPs
--     if will_use_lsp then
--       local clients = vim.lsp.get_clients({ bufnr = buf })
--       local names = {}
--       for _, c in ipairs(clients) do
--         if c.supports_method and (c:supports_method('textDocument/formatting') or c:supports_method('textDocument/rangeFormatting')) then
--           table.insert(names, c.name)
--         end
--       end
--       if #names > 0 then
--         print('Formatted via LSP(s): ' .. table.concat(names, ', '))
--       else
--         print('No formatter detected (Conform planned LSP but no LSP reported formatting)')
--       end
--       return
--     end
--
--     -- otherwise, report planned candidates if any, else say nothing found
--     if #planned_names > 0 then
--       print('Planned formatters were: ' .. table.concat(planned_names, ', '))
--     else
--       print('No formatter lines detected in conform.log')
--     end
--   end, 300)
-- end

local ch = require("utils.conform_helpers")

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      python = { "black" },
      lua = { "stylua" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
    })
    opts.log_level = vim.log.levels.INFO
    opts.default_format_opts = opts.default_format_opts or {}
    opts.default_format_opts.lsp_format = "fallback"
    return opts
  end,
  keys = {
    {
      "<leader>fl",
      function()
        ch.check_initial_logfile()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        require("conform").format({
          lsp_fallback = false,
          async = false,
          range = { start = { row, 0 }, ["end"] = { row, 0 } },
          timeout_ms = 500,
        }, ch.get_formatter)
      end,
      mode = { "n", "v" },
      desc = "Format line and report which formatter(s) ran",
    },
    {
      "<leader>fa",
      function()
        ch.check_initial_logfile()
        require("conform").format({ lsp_fallback = false, async = false, timeout_ms = 500 }, ch.get_formatter)
      end,
      mode = { "n", "v" },
      desc = "Format file and report which formatter(s) ran",
    },
  },
}
