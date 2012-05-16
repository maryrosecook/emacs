;; load paths
(add-to-list 'load-path "~/.emacs.d/")

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'load-path "~/.emacs.d/vendor/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; coffeescript major mode
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

;; peg mode
(autoload 'peg-mode "peg-mode" "Mode for editing PEG grammar files" t)
(setq auto-mode-alist
      (append '(("\\.peg$"    . peg-mode))
              auto-mode-alist))

;; clojure mode
(add-to-list 'load-path "~/.emacs.d/clojure-mode")
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode)) ;; use clojure-mode for clojurescript files

;; vc-diff colours
(require 'diff-mode-)

;; add git to shell path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/git/bin"))
(setq exec-path (append exec-path '("/usr/local/git/bin")))

;; add node to shell path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; disable annoying backups and autosaves
(setq backup-inhibited t)
(setq auto-save-default nil)

;; set all buffers to auto-revert when they were changed in the background
(global-auto-revert-mode t)

;; smooth scrolling
(require 'smooth-scroll)
(smooth-scroll-mode t)

;; multi web mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("htm" "html" "erb"))
(multi-web-global-mode 1)

;; Standard Emacs functionality
(setq-default comint-prompt-read-only t)
(setq-default indent-tabs-mode nil)
(setq-default inhibit-startup-message t)
(setq-default next-line-add-newlines nil)
(setq-default require-final-newline nil)
(setq-default scroll-step 1)
(menu-bar-mode nil)
(tool-bar-mode nil)
(tool-bar-mode 0)
(scroll-bar-mode nil)
(column-number-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat (user-login-name) "/tmp/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

(require 'color-theme)
(setq color-theme-is-global nil)

(require 'haml-mode)

;;aliases
(defalias 'dm 'diff-mode)

;;setup textmate mode and peepopen
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'textmate)
(require 'peepopen)
(textmate-mode)
(setq ns-pop-up-frames nil) ;; never open files in new emacs window
(defun open (project) (interactive (list (read-directory-name "Peepopen for project: " "~/code/")))
  (flet ((textmate-project-root () (file-truename project)))
    (peepopen-goto-file-gui)))
(global-set-key [(meta ?o)] 'open)

;; set ruby highlighting for files without .rb extension
(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; inserts js log call and puts cursor between brackets
(defun js-insert-console ()
  (interactive)
  (insert "console.log()")
  (backward-char))

;; inserts js log call and puts cursor between brackets
(defun html-insert-code ()
  (interactive)
  (insert "<code></code>")
  (backward-char) (backward-char) (backward-char) (backward-char) (backward-char) (backward-char) (backward-char))

;; inserts js log call and puts cursor between brackets
(defun js-insert-function ()
  (interactive)
  (insert "function() {}")
  (backward-char))

;; narrower window, better line wrapping for prose
(defun write-words ()
  (interactive)
  (color-theme-emacs-21-custom)
  ;;(set-face-background 'fringe "#ffffff")
  (setq line-spacing 2)
  (set-frame-width nil 90)
  (set-frame-height nil 50)

  (visual-line-mode t)
  (setq mode-line-format nil)
  (show-paren-mode 0))

;; widescreen, no line-wrap
(defun write-code ()
  (color-theme-initialize)
  (color-theme-blackboard)
  (interactive)
  ;;(set-face-background 'fringe "#0C1021")
  (visual-line-mode 0)
  (setq line-spacing 0)
  (show-paren-mode 1)
  ;; (set-frame-width nil 90)
  ;; (set-frame-height nil 50)

  (setq mode-line-format
    (list "-"
          'mode-line-mule-info
          'mode-line-modified
          'mode-line-frame-identification
          'mode-line-buffer-identification
          "   "
          'mode-line-position
          "   "
          ;;'mode-line-modes
          '(which-func-mode ("" which-func-format))
          '(global-mode-string (global-mode-string)))))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
    (filename (buffer-file-name)))
    (if (not filename)
    (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
    (progn
      (rename-file name new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil))))))

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))

;; don't eat my shell
(setq-default comint-prompt-read-only t)

;; type over selection
(delete-selection-mode 1)

;; Make colours in Emacs' shell look normal
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Don't auto-truncate lines in shell mode
(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))

;; no more accidental minimising
(global-unset-key "\C-z")

;; no more accidental transposing when trying to yank
(global-unset-key "\C-t")
;; Key bindings
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-x\C-z" 'shell) ;; shortcut for shell
(global-set-key "\C-z\C-x" 'shell-command) ;; shortcut for shell command
(global-set-key (read-kbd-macro "C-x g") 'rgrep)
(global-set-key (kbd "RET") 'newline-and-indent) ;; indent previous line after
(global-set-key (read-kbd-macro "C-x l") 'js-insert-console) ;; insert console.log()
(global-set-key (read-kbd-macro "C-x f") 'js-insert-function) ;; insert function() {}
(global-set-key (read-kbd-macro "C-x e") 'html-insert-code) ;; insert <code></code>
(global-set-key (read-kbd-macro "C-x w") 'write-words)
(global-set-key (read-kbd-macro "C-x c") 'write-code)
(global-set-key (read-kbd-macro "M-s") 'query-replace)
(global-set-key "\C-x\C-r" 'revert-buffer-no-confirm) ;; remap revert buffer
(global-set-key "\C-x\M-r" 'rename-file-and-buffer)

(modify-syntax-entry ?_ "w" js-mode-syntax-table)

;; map start of file and end of file commands to nicer key combos
(global-set-key (read-kbd-macro "M-[") 'beginning-of-buffer)
(global-set-key (read-kbd-macro "M-]") 'end-of-buffer)

;; remap dynamic expansion to escape
(global-set-key (kbd "<escape>") 'dabbrev-expand)

;; bind key to go full screen (os x and fullscreen brew install of emacs 23 only)
(global-set-key (read-kbd-macro "C-x t") 'ns-toggle-fullscreen)

;; set indent levels
(setq default-tab-width 2)
(setq js-indent-level 2)
(setq js2-indent-level 2)
(setq ruby-indent-level 2)

;; can't remember what this does
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; pipe down
(setq bell-volume 0)
(setq sound-alist nil)

;; tramp - /sub.server.com:public_html/foo.html
(require 'tramp)
(setq tramp-default-method "scp")

(set-default-font "-*-bitstream vera sans mono-*-*-*-*-*-106-*-*-*-*-*-*")
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:height 125 :family "Inconsolata"))))
 '(diff-added ((((background dark)) (:foreground "#FFFF9B9BFFFF")) (t (:foreground "DarkGreen"))) t)
 '(diff-changed ((((background dark)) (:foreground "Yellow")) (t (:foreground "MediumBlue"))) t)
 '(diff-context ((((background dark)) (:foreground "White")) (t (:foreground "Black"))) t)
 '(diff-file-header ((((background dark)) (:foreground "Cyan" :background "Black")) (t (:foreground "Red" :background "White"))) t)
 '(diff-file2-hunk-header ((((background dark)) (:background "#000088"))))
 '(diff-function ((t nil)))
 '(diff-header ((((background dark)) (:foreground "Cyan")) (t (:foreground "Red"))) t)
 '(diff-hunk-header ((((background dark)) (:foreground "Black" :background "#05057F7F8D8D")) (t (:foreground "White" :background "Salmon"))) t)
 '(diff-index ((((background dark)) (:foreground "Magenta")) (t (:foreground "Green"))) t)
 '(diff-indicator-added ((((background dark)) (:background "#003300" :foreground "#fff"))))
 '(diff-indicator-removed ((((background dark)) (:background "#550000" :foreground "#FFFFFF"))))
 '(diff-nonexistent ((((background dark)) (:foreground "#FFFFFFFF7474")) (t (:foreground "DarkBlue"))) t)
 '(diff-removed ((((background dark)) (:foreground "#7474FFFF7474")) (t (:foreground "DarkMagenta"))) t)
 '(js2-external-variable-face ((t (:foreground "white")))))

;; add bash completion
(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)
(add-hook 'shell-command-complete-functions
  'bash-completion-dynamic-complete)

(write-code)

;; enable ido mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(fringe-mode '(1 . 0))

(setq-default cursor-type '(bar . 1))
(set-cursor-color '"#FFFFFF")

(set-frame-height nil 50)

;; start with the shell open
(shell)
