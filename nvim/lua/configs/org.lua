local ok, orgmode = pcall(require, "orgmode")
if not ok then
  return
end

local M = {}

orgmode.setup_ts_grammar()
orgmode.setup{
  org_agenda_files = {'~/notes/org/*'},
  org_default_notes_file = '~/notes/org/notes.org',
  org_todo_keywords = {'TODO', 'WAITING', '|', 'DONE', 'DELEGATED'},
  org_todo_keyword_faces = {
    WAITING = ':foreground blue :weight bold',
    DELEGATED = ':background #FFFFFF :slant italic :underline on',
    TODO = ':background #000000 :foreground red', -- overrides builtin color for `TODO` keyword
  },
  mappings = {
    disable_all = true, -- Set these in which-key directly
  }
}

local function remapper(action, desc)
  local mapping = {}
  mapping[1] = "<cmd>lua require('orgmode').action('org_mappings."..action.."')<cr>"
  mapping[2] = desc
  print(vim.inspect(mapping))
  return mapping
end

M.which_key_mappings = {
  a = {
    name = "+attachments",
  },
  A = {
    name = "org-archive-subtree",
  },
  b = {
    name = "+tables",
  },
  c = {
    name = "+clock",
  },
  d = {
    name = "date/deadline",
    d = remapper("org_deadline", "org-deadline"),
    s = remapper("", "org-schedule"),
    t = remapper("", "org-timestamp"),
    T = remapper("", "org-timestamp-inactive"),
  },
  e = {
    name = "+org-export-dispatch",
  },
  f = {
    name = "+org-footnote-action",
  },
  g = {
    name = "+goto",
  },
  h = {
    name = "org-toggle-heading",
  },
  i = {
    name = "org-toggle-item",
  },
  I = {
    name = "org-id-get-create",
  },
  k = {
    name = "org-babel-remove-result",
  },
  K = {
    name = "+org/remove-result-blocks",
  },
  l = {
    name = "+links",
  },
  n = {
    name = "org-store-link",
  },
  o = {
    name = "org-set-property",
  },
  p = {
    name = "+priority",
  },
  P = {
    name = "+publish",
  },
  q = {
    name = "org-set-tags-command",
  },
  r = {
    name = "+refile",
  },
  s = {
    name = "+tree/subtree",
  },
  t = {
    name = "org-todo",
    t = remapper("todo_next_state", "[t] TODO")
  },
  T = {
    name = "org-todo-list",
  },
  u = {
    name = "Update All DBlocks",
  },
  x = {
    name = "org-toggle-checkbox",
  },
}
return M
