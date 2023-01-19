local awful = require ("awful")
local gears = require ("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local AWESOME_CONFIGS_PATH = "/home/jimmy/awesome/"

local M = {}

M.switch_configs = function(config)
  awful.spawn.with_shell("rm ~/.config/awesome && ln -s " .. AWESOME_CONFIGS_PATH .. config .. " ~/.config/awesome")
  awesome.restart()
end

M.list_configs = function()
  local configs = {}

  awful.spawn.easy_async("ls " .. AWESOME_CONFIGS_PATH, function(stdout)
    local config_items = stdout:gmatch("[^\r\n]+")
      for s in config_items do
        gears.table.merge(configs, {
          {
            s,
            function()
              M.switch_configs(s)
            end,
          },
        })
      end
  end)
  return configs
end

M.config_switcher = function(config)
  awful.spawn.with_shell("rm ~/.config/awesome && ln -s ~/awesome/" .. config .. " ~/.config/awesome")
  awesome.restart()
end

M.basic_notify = function(title, message)
  naughty.notify {
    title = title,
    text = message,
    timeout = 3,
  }
end

-- Awesome notification with icon on the left
M.fancy_notify = function(title, message)
  naughty.notify {
    title = title,
    text = message,
    timeout = 3,
  }
end

-- Elenapan helpers
M.color = function(text, color)
  return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

M.vertical_pad = function(height)
  return wibox.widget {
    forced_height = height,
    layout = wibox.layout.fixed.vertical,
  }
end


return M
