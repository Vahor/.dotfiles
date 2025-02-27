return {
  {
    'mfussenegger/nvim-jdtls',
    config = function()
      local home = os.getenv 'HOME'

      -- File types that signify a Java project's root directory. This will be
      -- used by eclipse to determine what constitutes a workspace
      local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml' }
      local root_dir = require('jdtls.setup').find_root(root_markers)

      local workspace_folder = home .. '/.local/share/eclipse/cache/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

      local function jdtls_setup(event)
        local jdtls = require 'jdtls'
        jdtls.start_or_attach {
          flags = {
            debounce_text_changes = 80,
            allow_incremental_sync = true,
          },
          single_file_support = true,
          root_dir = root_dir,
          settings = {
            java = {
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              signatureHelp = {
                enabled = true,
              },
              import = { enabled = true },
              rename = { enabled = true },
              contentProvider = {
                preferred = 'fernflower',
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              codeGeneration = {
                toString = {
                  template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                hashCodeEquals = {
                  useJava7Objects = true,
                },
                useBlocks = true,
              },

              configuration = {
                runtimes = {
                  {
                    name = 'JavaSE-21',
                    path = home .. '/.local/share/mise/installs/java/21/',
                  },
                },
              },
            },
          },

          -- cmd is the command that starts the language server. Whatever is placed
          -- here is what is passed to the command line to execute jdtls.
          -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
          -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
          -- for the full list of options
          cmd = {
            home .. '/.local/share/mise/installs/java/21/bin/java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1G',
            '-Xmx4G',
            -- Lombok plugin
            '-javaagent:'
              .. home
              .. '/.local/share/eclipse/lombok.jar',
            -- jdtls TODO: maj version
            '-jar',
            vim.fn.glob '/opt/homebrew/Cellar/jdtls/1.44.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar',
            '-configuration',
            '/opt/homebrew/Cellar/jdtls/1.44.0/libexec/config_mac/',
            '-data',
            workspace_folder,
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
          },
        }
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'java' },
        callback = jdtls_setup,
        desc = 'Java language server - setup jdtls',
        group = vim.api.nvim_create_augroup('java-cmds', { clear = true }),
      })
    end,
  },
}
