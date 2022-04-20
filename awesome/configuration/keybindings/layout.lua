local awful = require "awful"

local function increase_width()
awful.tag.incmwfact(0.05)
end
local function decrease_width()
awful.tag.incmwfact(-0.05)
end
local function next_layout()
  awful.layout.inc(1)
end
local function increase_columns()
awful.tag.incncol(1, nil, true)
end
local function decrease_columns()
awful.tag.incncol(-1, nil, true)
end
local function increase_masters()
awful.tag.incnmaster(1, nil, true)
end
local function decrease_masters()
awful.tag.incnmaster(-1, nil, true)
end

local layout_bindings = {
  {{ modkey },        "l",     increase_width,   "increase master width factor"         },
  {{ modkey },        "h",     decrease_width,   "decrease master width factor"         },
  {{ modkey },        "space", next_layout,      "select next"                          },
  {{ modkey, ctrl },  "h",     increase_columns, "increase the number of columns"       },
  {{ modkey, ctrl },  "l",     decrease_columns, "decrease the number of columns"       },
  {{ modkey, shift }, "h",     increase_masters, "increase the number of master clients"},
  {{ modkey, shift }, "l",     decrease_masters, "decrease the number of master clients"},
}

return setKeys(layout_bindings, "layout")
