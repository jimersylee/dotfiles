return {
  -- 配置 Treesitter 支持 PHP 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php" })
      end
    end,
  },

  -- 配置 LSP - 只使用 intelephense
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 明确禁用其他 PHP LSP 服务器
        phpactor = false,
        psalm = false,
        -- 只启用 intelephense
        intelephense = {
          settings = {
            intelephense = {
              -- 基本配置
              licenceKey = nil, -- 如果有许可证，可以在这里填写
              clearCache = false,

              -- 诊断配置 - 只使用 intelephense 的诊断
              diagnostics = {
                enable = true,
                run = "onType", -- 实时诊断
                maxLineLength = 0, -- 禁用行长度检查
                maxDocumentLineLength = 0, -- 禁用文档行长度检查
                undefinedTypes = true,
                undefinedFunctions = true,
                undefinedConstants = true,
                undefinedClassConstants = true,
                undefinedMethods = true,
                undefinedProperties = true,
                undefinedVariables = true,
                unusedVariables = true,
              },

              -- 格式化配置
              format = {
                enable = true, -- 启用内置格式化
                braces = "k&r", -- 大括号风格
                insertSpaces = true, -- 使用空格
                tabSize = 4, -- 缩进大小
                maxLineLength = 0, -- 不限制行长度
                wrapLineLength = 0, -- 不限制换行长度
              },

              -- 其他配置
              telemetry = {
                enable = false, -- 禁用遥测
              },
              completion = {
                maxItems = 100,
                triggerParameterHints = true,
                insertUseDeclaration = true,
                fullyQualifyGlobalConstantsAndFunctions = false,
              },

              -- 文件配置
              files = {
                maxSize = 5000000, -- 5MB
                associations = { "*.php", "*.phtml" },
                exclude = {
                  "**/node_modules/**",
                  "**/vendor/**/{Tests,tests}/**",
                  "**/.git/**",
                },
              },
            },
          },
        },
      },
    },
  },

  -- 确保通过 Mason 安装 intelephense
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "intelephense" })
    end,
  },

  -- 强制禁用 nvim-lint 对 PHP 的所有检查
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- 完全清空 PHP 的 linters
      opts.linters_by_ft.php = {}

      -- 也清理可能存在的全局linters定义
      if opts.linters then
        opts.linters.phpcs = nil
        opts.linters.phpstan = nil
        opts.linters.psalm = nil
      end

      return opts
    end,
  },

  -- 强制禁用 none-ls/null-ls 的所有 PHP 相关功能
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      -- 彻底过滤所有 PHP 相关的 sources
      local filtered_sources = {}
      for _, source in ipairs(opts.sources) do
        local should_exclude = false

        -- 检查source名称
        if source.name then
          local name_lower = source.name:lower()
          if
            name_lower:match("php")
            or name_lower == "phpcs"
            or name_lower == "phpcbf"
            or name_lower == "phpstan"
            or name_lower == "psalm"
            or name_lower == "php_cs_fixer"
          then
            should_exclude = true
          end
        end

        -- 检查method类型和filetypes
        if source.filetypes and vim.tbl_contains(source.filetypes, "php") then
          should_exclude = true
        end

        if not should_exclude then
          table.insert(filtered_sources, source)
        end
      end

      opts.sources = filtered_sources
      return opts
    end,
  },

  -- 配置 conform.nvim 只使用 LSP 格式化
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- 强制使用 LSP (intelephense) 进行格式化
      opts.formatters_by_ft.php = { "lsp" }

      -- 清理可能存在的PHP formatters定义
      if opts.formatters then
        opts.formatters.phpcs = nil
        opts.formatters.phpcbf = nil
        opts.formatters["php-cs-fixer"] = nil
        opts.formatters["php_cs_fixer"] = nil
      end

      return opts
    end,
  },

  -- PHP 文件类型特定配置和诊断清理
  {
    "LazyVim/LazyVim",
    opts = function()
      -- 为 PHP 文件添加自动命令
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function(ev)
          -- PHP 代码风格设置
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
          vim.opt_local.softtabstop = 4
          vim.opt_local.expandtab = true

          -- 延迟清理非intelephense的诊断
          vim.defer_fn(function()
            local diagnostics = vim.diagnostic.get(ev.buf)
            local filtered_diagnostics = {}

            for _, diag in ipairs(diagnostics) do
              -- 只保留intelephense或无source的诊断
              if not diag.source or diag.source == "intelephense" then
                table.insert(filtered_diagnostics, diag)
              else
                -- 打印被过滤的诊断信息，方便调试
                print(string.format("Filtered diagnostic from: %s", diag.source))
              end
            end

            -- 如果有被过滤的诊断，重新设置
            if #filtered_diagnostics ~= #diagnostics then
              vim.diagnostic.reset(nil, ev.buf)
              if #filtered_diagnostics > 0 then
                vim.diagnostic.set(nil, ev.buf, filtered_diagnostics)
              end
            end
          end, 2000) -- 2秒延迟，确保所有插件都加载完成
        end,
      })
    end,
  },
}
