(setq user-full-name "Jimmy Cozza"
      user-mail-address "jimmycozza@duck.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 18))

(setq doom-theme 'doom-gruvbox)
(setq doom-themes-treemacs-theme "doom-colors")

(setq display-line-numbers-type t)
(setq org-directory "~/notes/org/")

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
(add-to-list 'default-frame-alist '(alpha . (92 . 90)))

;; nohlsearch is baked into my brain
(map! :leader
      :desc "nohlsearch"
      "s c " #'evil-ex-nohighlight)

;; Org Mode update all dblocks TODO: Change this to only apply to org mode
(map! :map org-mode-map
      :leader
      :desc "Update All Dblocks"
      "m u" #'org-update-all-dblocks)

;; Comment the damn line
(map! :leader
      :desc "Comment Line"
      "c l " #'comment-line)

;; Left and Right move to linting errors
(map! :n "<left>" #'flycheck-previous-error)
(map! :n "<right>" #'flycheck-next-error)

(setq evil-split-window-right t)
(setq evil-split-window-below t)

(setq org-directory "~/notes/org/")
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-start-with-log-mode t)

(setq org-agenda-files
'("~/notes/org/habit.org"
  "~/notes/org/todo.org"
  "~/notes/org/notes.org"
  "~/notes/org/organizer.org"
  "~/notes/org/projects.org"
  "~/notes/org/schedule.org"
  "~/notes/org/standups.org"))

(after! org
  ;; Org Habit
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)
  ;; Replace list hyphen with dot
  (defun efs/org-font-setup ()
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                          (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.5)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 0.9)
                  (org-level-6 . 0.9)
                  (org-level-7 . 0.9)
                  (org-level-8 . 0.9)))
  (set-face-attribute (car face) nil :font "JetBrainsMono Nerd Font" :weight 'regular :height (cdr face)))
  (setq org-ellipsis " ▾"))

;; Loads ox-gfm for github flavored markdown exports
(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; Each path is relative to the path of the maildir you passed to mu
(set-email-account! "moatcozza@gmail.com"
  '((mu4e-sent-folder       . "/gmail/Sent Mail")
    (mu4e-drafts-folder     . "/gmail/Drafts")
    (mu4e-trash-folder      . "/gmail/Trash")
    (mu4e-refile-folder     . "/gmail/All Mail")
    (smtpmail-smtp-user     . "moatcozza@gmail.com")
    (mu4e-compose-signature . "---\nJimmy Cozza"))
  t)

;; if "gmail" is missing from the address or maildir, the account must be listed here
(setq +mu4e-gmail-accounts '(("moatcozza@gmail.com" . "/moatcozza")))

;; don't need to run cleanup after indexing for gmail
(setq mu4e-index-cleanup nil
      ;; because gmail uses labels as folders we can use lazy check since
      ;; messages don't really "move"
      mu4e-index-lazy-check t)
