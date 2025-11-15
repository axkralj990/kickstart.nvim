return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = function()
    local picker_config = require 'config.snacks'
    local zen_config = require 'config.zen'
    return {
      picker = picker_config[1],
      zen = zen_config[1],
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      lazygit = { enabled = true },
      terminal = { enabled = true },
      scratch = { enabled = true },
      toggle = { enabled = true },
      animate = { enabled = true }, -- smooth scrolling and animations
      indent = {
        enabled = true,
        indent = {
          enabled = true,
          char = '│',
        },
        scope = {
          enabled = true,
        },
      },
      input = { enabled = true }, -- better vim.ui.input
      scope = { enabled = true }, -- scope detection
      scroll = { enabled = true }, -- smooth scrolling
      bufdelete = { enabled = true }, -- better buffer deletion
    }
  end,
  keys = {
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle [Z]en Mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle [Z]en Zoom',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git [B]lame Line',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git [B]rowse',
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Log (current [F]ile)',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit [L]og',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = '[S]elect Scratch Buffer',
    },
    {
      '<leader>n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Show [N]otification History',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = '[R]ename File',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = '[D]elete Buffer',
    },
    {
      '<leader>bD',
      function()
        Snacks.bufdelete.other()
      end,
      desc = '[D]elete Other Buffers',
    },
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<c-_>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal (which-key)',
      mode = { 'n', 't' },
    },
    {
      '<leader>N',
      function()
        Snacks.notifier.show_history()
      end,
      desc = '[N]otification History',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal' })
          :map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
