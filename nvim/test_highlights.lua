-- Test file for mini.hipatterns highlighting

-- TODO: This should be highlighted as a TODO
-- FIXME: This should be highlighted as a FIXME
-- HACK: This should be highlighted as a HACK
-- NOTE: This should be highlighted as a NOTE

-- Test hex colors
local colors = {
  red = "#ff0000",
  green = "#00ff00",
  blue = "#0000ff",
  white = "#ffffff",
  black = "#000000",
}

-- Test comment functionality
-- gcc should toggle this line comment
-- gc in visual mode should comment selection
local function test()
  print("Testing mini.comment")
  -- TODO: Add more tests here
end