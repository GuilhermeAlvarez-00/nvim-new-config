return {
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "maxmx03/fluoromachine.nvim",
      lazy = false,
      priority = 1000,
      config = function()
      	local fm = require("fluoromachine")
          fm.setup {
            glow = false,
            theme = "fluoromachine",
            transparent = true,
            brightness = 0.01,
        }
    	end,
    },
}
