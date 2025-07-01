;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; Font configuration for proper icon display
;; Try this first - using the exact font names from your system
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 14)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 20))

;; Alternative font configuration if above doesn't work
;; Uncomment these lines and comment out the above if needed:
;; (setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 14)
;;       doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 14)
;;       doom-symbol-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 14)
;;       doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 20))

;; Ensure all-the-icons fonts are properly installed and configured
(use-package! all-the-icons
  :config
  ;; Install fonts if they don't exist
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

;; Configure nerd-icons (newer icon system)
(use-package! nerd-icons
  :config
  ;; Install nerd-icons fonts if they don't exist
  (unless (find-font (font-spec :name "Symbols Nerd Font Mono"))
    (nerd-icons-install-fonts t)))

;; Configure modeline for proper icon display
(after! doom-modeline
  (setq doom-modeline-icon t                    ; Enable icons in modeline
        doom-modeline-major-mode-icon t         ; Show major mode icon
        doom-modeline-major-mode-color-icon t   ; Colorize major mode icon
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-unicode-fallback nil      ; Don't fallback to unicode
        doom-modeline-height 25)                ; Slightly taller modeline
  
  ;; Force icon refresh
  (doom-modeline-mode 1))

;; Additional icon configuration
(after! all-the-icons
  ;; Refresh icon fonts if needed
  (setq all-the-icons-scale-factor 1.0)
  
  ;; Add custom icon associations if needed
  (setq all-the-icons-file-icon-alist
        (append all-the-icons-file-icon-alist
                '(("\\.env$" all-the-icons-fileicon "config" :face all-the-icons-yellow)))))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Environment configuration
;; Load environment variables from dotfiles .env file
(load-file "~/dotfiles/.env")

;; Configure line numbers and basic editor behavior
(setq display-line-numbers-type 'relative)  ; Relative line numbers like nvim
(setq-default tab-width 2
              indent-tabs-mode nil)  ; 2-space indentation

;; Better defaults
(setq confirm-kill-emacs nil  ; Don't ask when quitting
      ring-bell-function 'ignore  ; No bell
      scroll-conservatively 1000  ; Better scrolling
      scroll-margin 3)  ; Keep 3 lines visible when scrolling


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Configure helpful package
(use-package! helpful
  :config
  ;; Replace the default Emacs help keybindings
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-h x") #'helpful-command)
  
  ;; Additional keybindings
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)
  (global-set-key (kbd "C-h F") #'helpful-function))

;; Core nvim-style keybindings
;; jk to escape and save in insert mode
(map! :i "jk" #'evil-normal-state-and-save)

;; Line manipulation shortcuts
(map! :n ";;" #'end-of-line-and-add-semicolon
      :n ",," #'end-of-line-and-add-comma
      :n "::" #'end-of-line-and-remove-char)

;; Move lines up/down with Alt+j/k
(map! :n "<A-j>" #'drag-stuff-down
      :n "<A-k>" #'drag-stuff-up
      :v "<A-j>" #'drag-stuff-down
      :v "<A-k>" #'drag-stuff-up)

;; Better search centering
(map! :n "n" #'better-search-forward
      :n "N" #'better-search-backward)

;; Navigate diagnostics
(map! :n "<right>" #'flycheck-next-error
      :n "<left>" #'flycheck-previous-error)

;; Quickfix navigation
(map! :n "<up>" #'previous-error
      :n "<down>" #'next-error)

;; Visual mode - delete and paste without replacing register
(map! :v "dp" #'delete-and-paste-preserve-register)

;; Terminal mode escape
(map! :t "<escape>" #'term-char-mode)

;; Window navigation (override defaults for consistency)
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;; Leader key bindings structure (matching nvim config)
(map! :leader
      ;; AI commands (SPC a)
      (:prefix-map ("a" . "ai")
       :desc "Toggle AI chat" "c" #'ai-chat-toggle
       :desc "AI actions menu" "a" #'ai-actions-menu
       :desc "Inline AI edit" "i" #'ai-inline-edit)
      
      ;; Buffer operations (SPC b)
      (:prefix-map ("b" . "buffer")
       :desc "Switch buffer" "b" #'consult-buffer
       :desc "Kill buffer" "k" #'kill-current-buffer
       :desc "List buffers" "l" #'ibuffer)
      
      ;; Comments (SPC c)
      (:prefix-map ("c" . "code")
       :desc "Comment line" "l" #'comment-line
       :desc "Comment region" "r" #'comment-or-uncomment-region)
      
      ;; Database (SPC d)
      (:prefix-map ("d" . "database")
       :desc "Toggle database UI" "t" #'database-ui-toggle)
      
      ;; Edit config files (SPC e)
      (:prefix-map ("e" . "edit")
       :desc "Edit doom config" "d" #'doom/open-private-config
       :desc "Edit init.el" "i" #'doom/goto-private-init-file)
      
      ;; Find operations (SPC f)
      (:prefix-map ("f" . "file")
       :desc "Find file" "f" #'find-file
       :desc "Find file in project" "p" #'projectile-find-file
       :desc "Recent files" "r" #'recentf-open-files
       :desc "Find in project" "/" #'consult-ripgrep)
      
      ;; Git operations (SPC g)
      (:prefix-map ("g" . "git")
       :desc "Git status" "s" #'magit-status
       :desc "Git blame" "b" #'magit-blame
       :desc "Git log" "l" #'magit-log-all
       :desc "Git diff" "d" #'magit-diff)
      
      ;; Help (SPC h)
      (:prefix-map ("h" . "help")
       :desc "Describe function" "f" #'helpful-callable
       :desc "Describe variable" "v" #'helpful-variable
       :desc "Describe key" "k" #'helpful-key)
      
      ;; LSP operations (SPC l)
      (:prefix-map ("l" . "lsp")
       :desc "LSP rename" "r" #'lsp-rename
       :desc "LSP code actions" "a" #'lsp-execute-code-action
       :desc "LSP find references" "R" #'lsp-find-references
       :desc "LSP find definition" "d" #'lsp-find-definition
       :desc "LSP format buffer" "f" #'lsp-format-buffer)
      
      ;; NvimTree equivalent (SPC n)
      (:prefix-map ("n" . "neotree")
       :desc "Toggle file tree" "n" #'treemacs
       :desc "Find file in tree" "t" #'treemacs-find-file)
      
      ;; Project operations (SPC p)
      (:prefix-map ("p" . "project")
       :desc "Switch project" "p" #'projectile-switch-project
       :desc "Find file in project" "f" #'projectile-find-file
       :desc "Search in project" "s" #'consult-ripgrep)
      
      ;; Tests (SPC T)
      (:prefix-map ("T" . "test")
       :desc "Run tests" "t" #'test-runner
       :desc "Run test file" "f" #'test-file-runner)
      
      ;; Additional single-key bindings
      :desc "Live grep" "/" #'consult-ripgrep
      :desc "Toggle file tree" "b" #'treemacs
      :desc "Clear search" "sc" #'evil-ex-nohighlight)

;; Helper functions for custom keybindings
(defun evil-normal-state-and-save ()
  "Exit insert mode and save buffer."
  (interactive)
  (evil-normal-state)
  (save-buffer))

(defun end-of-line-and-add-semicolon ()
  "Add semicolon at end of line."
  (interactive)
  (end-of-line)
  (insert ";"))

(defun end-of-line-and-add-comma ()
  "Add comma at end of line."
  (interactive)
  (end-of-line)
  (insert ","))

(defun end-of-line-and-remove-char ()
  "Remove character at end of line."
  (interactive)
  (end-of-line)
  (delete-char -1))

(defun better-search-forward ()
  "Search forward and center result."
  (interactive)
  (evil-search-next)
  (evil-scroll-line-to-center nil))

(defun better-search-backward ()
  "Search backward and center result."
  (interactive)
  (evil-search-previous)
  (evil-scroll-line-to-center nil))

(defun delete-and-paste-preserve-register ()
  "Delete selection and paste without replacing kill ring."
  (interactive)
  (let ((saved-kill-ring kill-ring))
    (delete-region (region-beginning) (region-end))
    (yank)
    (setq kill-ring saved-kill-ring)))

;; LSP Configuration - matching nvim setup
(after! lsp-mode
  ;; LSP UI improvements
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t
        lsp-headerline-breadcrumb-enable t
        lsp-enable-file-watchers t
        lsp-auto-guess-root t
        lsp-keep-workspace-alive nil)
  
  ;; Performance optimizations
  (setq lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-completion-provider :none  ; Use Corfu instead
        lsp-enable-snippet t
        read-process-output-max (* 1024 1024)  ; 1MB
        gc-cons-threshold 100000000)  ; 100MB
  
  ;; Go with gopls
  (after! go-mode
    (setq lsp-go-use-gofumpt t
          lsp-go-gofumpt t
          lsp-go-use-goimports t))
  
  ;; C/C++ with clangd
  (after! cc-mode
    (setq lsp-clients-clangd-args '("-j=8"
                                    "--background-index"
                                    "--clang-tidy"
                                    "--completion-style=detailed"
                                    "--header-insertion=never"
                                    "--header-insertion-decorators=0")))
  
  ;; Lua with lua-language-server
  (after! lua-mode
    (setq lsp-lua-workspace-library
          (list (expand-file-name "~/.local/share/nvim/lazy/neodev.nvim/types/stable")
                (expand-file-name "/usr/share/awesome/lib"))))
  
  ;; JSON with schema support
  (after! json-mode
    (setq lsp-json-schemas
          `[(:fileMatch ["package.json"] :url "https://json.schemastore.org/package.json")
            (:fileMatch ["tsconfig*.json"] :url "https://json.schemastore.org/tsconfig.json")
            (:fileMatch [".eslintrc" ".eslintrc.json"] :url "https://json.schemastore.org/eslintrc.json")]))
  
  ;; Zig with zls
  (after! zig-mode
    (setq lsp-zig-zls-executable "zls"))
  
  ;; LSP keybindings (Evil mode)
  (map! :map lsp-mode-map
        :n "gD" #'lsp-find-declaration
        :n "gd" #'lsp-find-definition
        :n "gi" #'lsp-find-implementation
        :n "gr" #'lsp-find-references
        :n "K" #'lsp-ui-doc-show
        :n "[d" #'lsp-ui-flycheck-list
        :n "]d" #'flycheck-next-error
        :n "<leader>e" #'lsp-ui-flycheck-list
        :n "<leader>rn" #'lsp-rename
        :n "<leader>ca" #'lsp-execute-code-action
        :n "<leader>f" #'lsp-format-buffer))

;; TypeScript specific configuration
(after! typescript-mode
  (map! :map typescript-mode-map
        :localleader
        :n "R" #'typescript-rename-file
        :n "I" #'typescript-organize-imports
        :n "A" #'typescript-add-import
        :n "F" #'typescript-fix-all))

;; Format on save configuration
(add-hook! '(typescript-mode-hook
             javascript-mode-hook
             go-mode-hook
             lua-mode-hook
             c-mode-hook
             c++-mode-hook
             zig-mode-hook
             json-mode-hook)
  (format-all-mode))

;; Configure format-all formatters to match nvim setup
(after! format-all
  (setq format-all-formatters
        '(("JavaScript" biome)
          ("TypeScript" biome)
          ("TSX" biome)
          ("JSX" biome)
          ("Go" gofmt)
          ("Lua" stylua)
          ("C" clang-format)
          ("C++" clang-format)
          ("JSON" biome)
          ("Zig" zig))))

;; Completion configuration - matching nvim-cmp behavior
(after! corfu
  ;; Enable Corfu globally
  (global-corfu-mode)
  
  ;; Corfu configuration
  (setq corfu-cycle t                ; Enable cycling for `corfu-next/previous'
        corfu-auto t                 ; Enable auto completion
        corfu-auto-delay 0.2         ; Auto completion delay
        corfu-auto-prefix 2          ; Minimum prefix length for auto completion
        corfu-separator ?\s          ; Orderless field separator
        corfu-quit-at-boundary nil   ; Never quit at completion boundary
        corfu-quit-no-match nil      ; Never quit, even if there is no match
        corfu-preview-current nil    ; Don't preview current candidate
        corfu-preselect 'prompt      ; Preselect the prompt
        corfu-on-exact-match nil     ; Don't auto-insert exact matches
        corfu-scroll-margin 5)       ; Scroll margin

  ;; TAB-and-Go completion behavior (like nvim)
  (map! :map corfu-map
        :i "TAB" #'corfu-next
        :i "<tab>" #'corfu-next
        :i "S-TAB" #'corfu-previous
        :i "<backtab>" #'corfu-previous
        :i "RET" #'corfu-insert
        :i "<return>" #'corfu-insert
        :i "M-SPC" #'corfu-insert-separator
        :i "<escape>" #'corfu-quit)
  
  ;; Enable orderless filtering like nvim fuzzy matching
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Cape configuration for additional completion sources
(after! cape
  ;; Add completion functions to completion-at-point-functions
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-dict))

;; Configure company (fallback) to match nvim-cmp behavior
(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-limit 20
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-dabbrev-code-other-buffers t
        company-tooltip-align-annotations t
        company-require-match 'never
        company-global-modes '(not eshell-mode comint-mode erc-mode rcirc-mode)
        company-backends '(company-capf company-files company-dabbrev)))

;; Yasnippet configuration (UltiSnips equivalent)
(after! yasnippet
  (setq yas-snippet-dirs (append yas-snippet-dirs '("~/dotfiles/snippets")))
  (yas-global-mode 1)
  
  ;; Keybindings for snippets
  (map! :map yas-minor-mode-map
        :i "C-j" #'yas-expand
        :i "C-l" #'yas-next-field
        :i "C-h" #'yas-prev-field))

;; Search and Navigation - Vertico/Consult for Telescope equivalent
(after! vertico
  (setq vertico-cycle t              ; Cycle through candidates
        vertico-resize t             ; Resize minibuffer
        vertico-count 20)            ; Show more candidates
  
  ;; Enable rich annotations for completion
  (marginalia-mode))

(after! consult
  ;; Configure consult for telescope-like behavior
  (setq consult-project-function #'projectile-project-root
        consult-narrow-key "<"     ; Narrow key like telescope
        consult-line-start-from-top t
        consult-async-min-input 2
        consult-async-refresh-delay  0.15
        consult-async-input-throttle 0.2
        consult-async-input-debounce 0.1)
  
  ;; Configure ripgrep for project search (like telescope live_grep)
  (setq consult-ripgrep-args
        "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --with-filename --line-number --search-zip\
   --hidden --glob=!.git/ --glob=!node_modules/ --glob=!package-lock.json")
  
  ;; Custom search function that excludes package-lock.json
  (defun my/consult-ripgrep-exclude-lockfiles ()
    "Search project with ripgrep excluding package-lock.json like nvim config."
    (interactive)
    (let ((consult-ripgrep-args
           (concat consult-ripgrep-args " --glob=!*lock* --glob=!*.lock")))
      (consult-ripgrep)))
  
  ;; Enhanced keybindings for telescope-like behavior
  (map! :leader
        :desc "Find files" "ff" #'find-file
        :desc "Find project files" "fp" #'projectile-find-file  
        :desc "Recent files" "fr" #'consult-recent-file
        :desc "Live grep" "/" #'my/consult-ripgrep-exclude-lockfiles
        :desc "Search buffers" "fb" #'consult-buffer
        :desc "Search lines" "fl" #'consult-line
        :desc "Search outline" "fo" #'consult-outline
        :desc "Search marks" "fm" #'consult-mark
        :desc "Search registers" "fR" #'consult-register))

;; Orderless for fuzzy matching like telescope
(after! orderless
  (setq orderless-component-separator #'orderless-escapable-split-on-space
        orderless-matching-styles '(orderless-literal
                                    orderless-prefixes
                                    orderless-initialism
                                    orderless-regexp
                                    orderless-flex)))

;; Enhanced project management
(after! projectile
  (setq projectile-project-search-path '("~/projects/" "~/code/" "~/dotfiles/")
        projectile-switch-project-action #'projectile-find-file
        projectile-sort-order 'recentf
        projectile-use-git-grep t
        projectile-indexing-method 'alien))

;; File tree configuration - Treemacs for nvim-tree equivalent
(after! treemacs
  (setq treemacs-width 35
        treemacs-is-never-other-window t
        treemacs-sorting 'alphabetic-case-insensitive-asc
        treemacs-follow-mode t
        treemacs-filewatch-mode t
        treemacs-fringe-indicator-mode 'always
        treemacs-git-mode 'simple
        treemacs-hide-dot-git-directory t
        treemacs-show-cursor nil
        treemacs-show-hidden-files t
        treemacs-silent-filewatch t
        treemacs-silent-refresh t
        treemacs-space-between-root-nodes t)
  
  ;; Custom file tree keybindings (matching nvim)
  (map! :map treemacs-mode-map
        :n "h" #'treemacs-root-up
        :n "l" #'treemacs-root-down
        :n "j" #'treemacs-next-line
        :n "k" #'treemacs-previous-line
        :n "RET" #'treemacs-RET-action
        :n "o" #'treemacs-visit-node-in-most-recent-window
        :n "s" #'treemacs-visit-node-in-horizontal-split  
        :n "v" #'treemacs-visit-node-in-vertical-split
        :n "r" #'treemacs-refresh
        :n "R" #'treemacs-rename-file
        :n "d" #'treemacs-delete-file
        :n "c" #'treemacs-copy-file
        :n "m" #'treemacs-move-file
        :n "n" #'treemacs-create-file
        :n "N" #'treemacs-create-dir
        :n "q" #'treemacs-quit)
  
  ;; Auto-close treemacs when opening a file
  (add-hook 'treemacs-select-hook #'treemacs-quit))

;; Git integration enhancement
(after! magit
  ;; Better magit defaults
  (setq magit-diff-refine-hunk t
        magit-repository-directories '(("~/projects" . 2)
                                       ("~/code" . 2)
                                       ("~/dotfiles" . 1))
        magit-save-repository-buffers 'dontask)
  
  ;; Enhanced git keybindings
  (map! :leader
        (:prefix-map ("g" . "git")
         :desc "Git status" "s" #'magit-status
         :desc "Git blame" "b" #'magit-blame-addition
         :desc "Git time machine" "t" #'git-timemachine-toggle
         :desc "Git log current" "l" #'magit-log-buffer-file
         :desc "Git log all" "L" #'magit-log-all
         :desc "Git diff" "d" #'magit-diff-buffer-file
         :desc "Git commit" "c" #'magit-commit
         :desc "Git push" "p" #'magit-push
         :desc "Git pull" "P" #'magit-pull)))

;; Terminal integration with vterm
(after! vterm
  (setq vterm-max-scrollback 10000
        vterm-buffer-name-string "vterm %s"
        vterm-kill-buffer-on-exit t)
  
  ;; Terminal keybindings
  (map! :leader
        (:prefix-map ("o" . "open")
         :desc "Terminal" "t" #'vterm
         :desc "Terminal here" "T" #'vterm-other-window))
  
  ;; Better terminal behavior
  (map! :map vterm-mode-map
        :i "C-q" #'vterm-send-next-key
        :i "C-c C-t" #'vterm-copy-mode))
