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
  return mapping
end

M.which_key_mappings = {
  a = {
    name = "+attachments",
    a = remapper("org-attach", "org-attach"),
    d = remapper("org-attach-delete-one", "org-attach-delete-one"),
    D = remapper("org-attach-delete-all", "org-attach-delete-all"),
    f = remapper("+org/find-file-in-attachments", "+org/find-file-in-attachments"),
    l = remapper("+org/attach-file-and-insert-link", "+org/attach-file-and-insert-link"),
    n = remapper("org-attach-new", "org-attach-new"),
    o = remapper("org-attach-open", "org-attach-open"),
    O = remapper("org-attach-open-in-emacs", "org-attach-open-in-emacs"),
    r = remapper("org-attach-reveal", "org-attach-reveal"),
    R = remapper("org-attach-reveal-in-emacs", "org-attach-reveal-in-emacs"),
    u = remapper("org-attach-url", "org-attach-url"),
    s = remapper("org-attach-set-directory", "org-attach-set-directory"),
    S = remapper("org-attach-sync", "org-attach-sync"),
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
    s = remapper("org_schedule", "org-schedule"),
    t = remapper("org_time_stamp", "org-timestamp"),
    T = remapper("org_time_stamp_inactive", "org-timestamp-inactive"),
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
