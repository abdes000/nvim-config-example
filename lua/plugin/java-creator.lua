return {
    "alessio-vivaldelli/java-creator-nvim",
    config = function()
      require("java-creator-nvim").setup({
        -- Customize templates for Java types
        templates = {
          class = [[package %s;

public class %s {
    // TODO: Implement class
}]],
          interface = [[package %s;

public interface %s {
    // TODO: Implement interface
}]],
          enum = [[package %s;

public enum %s {
    // TODO: Add enum values
}]],
          record = [[package %s;

public record %s() {
    // TODO: Add record components
}]],
          abstract_class = [[package %s;

public abstract class %s {
    // TODO: Implement abstract class
}]],
        },

        -- Default imports for each type
        default_imports = {
          record = { "java.util.*", "java.io.Serializable" },
          class = { "java.util.*" },
        },

        -- Custom key mappings
        keymaps = {
          java_new = "<leader>jn",                      -- Interactive Java file creation
          java_class = "<leader>jc",                    -- Create new class
          java_interface = "<leader>ji",                -- Create new interface
          java_enum = "<leader>je",                     -- Create new enum
          java_record = "<leader>jr",                   -- Create new record
          java_abstract_class = "<leader>ja",           -- Create new abstract class
        },

        -- General options
        options = {
          auto_open = true,                      -- Automatically open created file
          use_notify = true,                     -- Use notifications (nvim-notify if available)
          notification_timeout = 3000,           -- Notification timeout in milliseconds
          java_version = 17,                     -- Target Java version
          src_patterns = {                       -- Patterns to find source directories
            "src/main/java",
            "src/test/java",
            "src"
          },
          project_markers = {           -- Files that identify a Java project
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
            "settings.gradle",
            "settings.gradle.kts",
            ".project"
          },
          custom_src_path = nil,           -- Custom source path (optional)
        }
      })

      vim.keymap.set("i", "<C-space>", 'pumvisible() ? "\\<C-n>" : "\\<C-x>\\<C-u>"', {
        expr = true,
        desc = "",
      })
    end,
    ft = "java",
    event = "VeryLazy",
    dependencies = {
      { "rcarriga/nvim-notify", optional = true },
    },
  }
