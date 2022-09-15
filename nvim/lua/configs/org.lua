local ok, orgmode = pcall(require, "orgmode")
if not ok then
  return
end

orgmode.setup_ts_grammar()
orgmode.setup{
  org_agenda_files = {'~/notes/org/*'},
  org_default_notes_file = '~/notes/org/notes.org',
  org_todo_keywords = {'TODO', 'WAITING', '|', 'DONE', 'DELEGATED'},
  org_todo_keyword_faces = {
    WAITING = ':foreground blue :weight bold',
    DELEGATED = ':background #FFFFFF :slant italic :underline on',
    TODO = ':background #000000 :foreground red', -- overrides builtin color for `TODO` keyword
  }
}
