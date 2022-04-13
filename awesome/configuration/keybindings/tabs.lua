local awful = require "awful"
local bling = require "module.bling"

local tab_bindings = {

  awful.key({ altkey }, "a", function()
    bling.module.tabbed.pick_with_dmenu()
  end, { description = "pick client to add to tab group", group = "tabs" }),
  awful.key({ altkey }, "s", function()
    bling.module.tabbed.iter()
  end, { description = "iterate through tabbing group", group = "tabs" }),
  awful.key({ altkey }, "d", function()
    bling.module.tabbed.pop()
  end, {
    description = "remove focused client from tabbing group",
    group = "tabs",
  }),
}

return tab_bindings
