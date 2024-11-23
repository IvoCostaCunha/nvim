return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufEnter",
  opts = {
    render = "background",
    virtual_symbol_prefix = "",
	  virtual_symbol_suffix = " ",
	  virtual_symbol_position = "inline",
	  enable_hex = true,
	  enable_short_hex = true,
	  enable_rgb = true,
	  enable_hsl = true,
	  enable_var_usage = true,
	  enable_named_colors = true,
	  enable_tailwind = true,
	  ---Set custom colors
	  ---Label must be properly escaped with "%" to adhere to `string.gmatch`
	  --- :help string.gmatch
	  custom_colors = {
		  { label = "%-%-theme%-primary%-color", color = "#0f1219" },
		  { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
	  },
 	  -- Exclude filetypes or buftypes from highlighting e.g. "exclude_buftypes = {"text"}"
    exclude_filetypes = {},
    exclude_buftypes = {}
  }
}
