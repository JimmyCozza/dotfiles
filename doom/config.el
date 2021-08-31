;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jimmy Cozza"
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "GoMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "GoMono Nerd Font" :size 16))
      ;; doom-variable-pitch-font (font-spec :family "Fira Code Nerd Font" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'gruvbox-dark-soft)
(setq doom-themes-treemacs-theme "doom-colors")

;; Transparent background
 (set-frame-parameter (selected-frame) 'alpha '(92 . 90))
 (add-to-list 'default-frame-alist '(alpha . (92 . 90)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; New Keybindings
(map! :leader
      :desc "nohlsearch"
      "s c " #'evil-ex-nohighlight)

(map! :map org-mode-map
      :leader
      :desc "Update All Dblocks"
      "m u" #'org-update-all-dblocks)

(map! :leader
      :desc "Comment Line"
      "c l " #'comment-line)

;;===================================================================================
;;                                    JAVASCRIPT
;; ===================================================================================
(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))
(add-hook 'js2-mode-hook 'eslintd-fix-mode)
(require 'dap-node)
(setq dap-node-debug-program "~/tools/vscode-node-debug2/out/src/nodeDebug.js")
(setq lsp-log-io t)
(setq dap-print-io t)
(dap-register-debug-template
  "Attach to node process "
  (list :type "node"
        :request "attach"
        :program "__ignored"
        :port 9230
        :name "Attach to node process in docker container"))
 ;(defun you-track-integration ()
  ;(interactive)
  ;(insert (shell-command-to-string (format "python3 %s" buffer-file-name))))
;;===================================================================================
;;                                    ORG MODE
;; ===================================================================================
;; Setting a TODO to DONE sets a Closed timestamp
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

(defun make-youtrack-link (yt_id)
  (browse-url (concat "https://growmies.myjetbrains.com/youtrack/issue/GA-" yt_id)))
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
  (set-face-attribute (car face) nil :font "GoMono Nerd Font" :weight 'regular :height (cdr face)))
  (setq org-ellipsis " ▾")
  (org-add-link-type "youtrack" #'make-youtrack-link))
