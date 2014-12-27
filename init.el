(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; load paths
(add-to-list 'load-path "~/.emacs.d/src/")

(add-to-list 'custom-theme-load-path "~/.emacs.d/src/themes")

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'load-path "~/.emacs.d/src/vendor/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; enable auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-show-menu nil)

;; tern (JS jump-to-definiton, function autocomplete)

(add-to-list 'load-path "~/.emacs.d/vendor/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;; little hack to make current line highlight after jumping to definition of symbol
(advice-add 'tern-go-to-position :after (lambda (&rest _) (global-hl-line-highlight)))

;; highlight the line that the cursor is currently on
(require 'hl-line+)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#06203b")

(advice-add 'hl-line-highlight :after #'his-tracing-function)

;; ioke mode
(require 'ioke-mode)

;; markdown mode with support for other langs
(setq load-path
      (append '("~/.emacs.d/polymode/" "~/.emacs.d/polymode/modes")
              load-path))

(require 'poly-R)
(require 'poly-markdown)

(require 'dash)

;; Make C-u equivalent to C-x (for my dvorak keyboard)
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

;; peg mode
(autoload 'peg-mode "peg-mode" "Mode for editing PEG grammar files" t)
(setq auto-mode-alist
      (append '(("\\.peg$"    . peg-mode))
              auto-mode-alist))

;; clojure mode
(add-to-list 'load-path "~/.emacs.d/src/clojure-mode")
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\.clj$" . clojure-mode))

;; (add-hook 'slime-repl-mode-hook
;;           (defun clojure-mode-slime-font-lock ()
;;             (require 'clojure-mode)
;;             (let (font-lock-mode)
;;               (clojure-mode-font-lock-setup))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3527fd78ef69e7f42481e6de5bf7782b5552a88bfe2a600cf9734b7a6d89b33f" default))))

;; add package manager
(add-to-list 'load-path "~/.emacs.d/src/packages/")
(require 'package) (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) (package-initialize)

;; vc-diff colours
(require 'diff-mode-)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat "tmp/places"))

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

;; automatically add newline to end of files on save
(setq-default require-final-newline t)

;; turn off scss auto compile on save
(setq scss-compile-at-save nil)

;; smooth scrolling
(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq scroll-conservatively 10000) ;; scroll by cursor move amount when move cursor past top or bottom of window

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
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat (user-login-name) "/tmp/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

(require 'haml-mode)

;; aliases
(defalias 'dm 'diff-mode)

;; set ruby highlighting for files without .rb extension
(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

(defun current-major-mode ()
  (buffer-local-value 'major-mode (current-buffer)))

;; inserts js/clj log call and puts cursor between brackets
(defun insert-print ()
  (interactive)
  (insert (cond ((string= (current-major-mode) "clojure-mode")
                 "(println )")
                (t
                 "console.log()")))
  (backward-char))

(eq (current-major-mode) "a")
;; inserts js log call and puts cursor between brackets
(defun insert-code-tags ()
  (interactive)
  (insert "<code></code>")
  (backward-char)(backward-char)(backward-char)(backward-char)
  (backward-char)(backward-char)(backward-char))

(defun insert-map ()
  (interactive)
  (insert "(map (fn [x] ) )")
  (backward-char) (backward-char) (backward-char))

(defun insert-reduce ()
  (interactive)
  (insert "(reduce (fn [acc x] ) )")
  (backward-char) (backward-char) (backward-char))

;; inserts js log call and puts cursor between brackets
(defun js-insert-function ()
  (interactive)
  (insert "function() {}")
  (backward-char))

;; returns t if without-ext would equal filename with its extension removed
(defun equal-without-extension (without-ext filename)
  (string=
   without-ext
   (let ((pieces (split-string filename "\\.")))
     (mapconcat 'identity
                (if (> (length pieces) 1)
                    (butlast pieces)
                  pieces) ;; no ext - just keep whole str
                "."))))

(defun free-name-in-list (items name)
  (not (-any? (lambda (x) (equal-without-extension name x))
              items)))

(defun free-filename (dirs filename)
  (and (-all? (lambda (x) (free-name-in-list (directory-files x) filename)) dirs)
       (free-name-in-list (-map 'buffer-name (buffer-list)) filename)))


;; Goes through passed dirs to see if any files exist that, when
;; their extension is removed, match n.
;; If yes, increments n and recurses. If no returns n.
;;   directory: dir in which to find available filename
;;   n:         integer to start at
;;   returns:   Filename
(defun get-next-scratch-file-name (dirs &optional n)
  (let ((n (or n 1)))
    (if (free-filename dirs (number-to-string n))
        (number-to-string n)
      (get-next-scratch-file-name dirs (+ n 1)))))
;; (get-next-scratch-file-name '("~/text/" "~/code/scratch/"))

(defun new-buffer-with-ready-file (dir name)
  (generate-new-buffer name)
  (set-buffer name)
  (switch-to-buffer name)
  (set-visited-file-name (concat dir name)))

;; make and save new file for text editing
(defun new-scratch-file ()
  (interactive)
  (let* ((text-dir "~/text/") (code-dir "~/code/scratch/")
         (dirs (list text-dir code-dir))
         (name (get-next-scratch-file-name dirs 350))
         (name (read-string "File name: " name)))
    (if (string-match "[.]+" name)
        (new-buffer-with-ready-file code-dir name)
      (new-buffer-with-ready-file text-dir (concat name ".txt")))))

;; narrower window, better line wrapping for prose
(defun write-words ()
  (interactive)
  (setq mode-line-format nil)
  (set-face-attribute 'default nil :font "bitstream vera sans mono-11")
  (set-frame-width (selected-frame) 80)
  (set-frame-height (selected-frame) 53)
  (setq line-spacing 2)
  (visual-line-mode t)
  (show-paren-mode 0))

;; widescreen, no line-wrap
(defun write-code ()
  (interactive)
  (show-paren-mode 1)
  (disable-theme 'adwaita)
  (load-theme 'blackboard)
  (set-cursor-color "#ffffff")
  (set-face-background 'fringe "#0C1021")
  (set-face-attribute 'default nil :font "bitstream vera sans mono-11")
  (set-frame-width (selected-frame) 80)
  (set-frame-height (selected-frame) 55)
  (visual-line-mode 0)
  (setq line-spacing 0)

  (setq mode-line-format
    (list "  "
          'mode-line-buffer-identification
          "   %p %l "
          "%m"
          ;; 'minor-mode-alist ;; don't show minor modes
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

;; no more switching frames when trying to select text
(global-set-key (kbd "<s-left>") 'beginning-of-line)
(global-set-key (kbd "<s-right>") 'end-of-line)

;; no more scrolling down when trying to cut/copy (dvorak layout)
(global-unset-key "\C-v")
(global-unset-key "\M-v")

;; no more global unset column when missing C-s during save
(global-unset-key "\C-x\C-n")

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-save 'if-exists)
(desktop-save-mode 1)
(setq desktop-restore-eager 20)
(setq desktop-globals-to-save
      (append '((extended-command-history . 20)
                (file-name-history        . 20)
                (grep-history             . 20)
                (compile-history          . 20)
                (minibuffer-history       . 20)
                (query-replace-history    . 10)
                (read-expression-history  . 20)
                (regexp-history           . 20)
                (regexp-search-ring       . 20)
                (search-ring              . 10)
                (shell-command-history    . 10)
                tags-file-name
                register-alist)))

;; Key bindings
(global-set-key "\M-u" 'execute-extended-command)
(global-set-key "\C-x\M-f" 'new-scratch-file)
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-x\C-z" 'shell) ;; shortcut for shell
(global-set-key "\C-z\C-x" 'shell-command) ;; shortcut for shell command
(global-set-key (read-kbd-macro "C-x g") 'rgrep)
(global-set-key (kbd "RET") 'newline-and-indent) ;; indent previous line after
(global-set-key (read-kbd-macro "C-x l") 'insert-print) ;; insert console.log()
(global-set-key (read-kbd-macro "C-x m") 'insert-map)
(global-set-key (read-kbd-macro "C-x n") 'insert-reduce)
(global-set-key (read-kbd-macro "C-x w") 'write-words)
(global-set-key (read-kbd-macro "C-x f") 'flyspell-mode)
(global-set-key (read-kbd-macro "C-x c") 'write-code)
(global-set-key (read-kbd-macro "C-x j") 'insert-code-tags)
(global-set-key (read-kbd-macro "C-x t") 'toggle-frame-fullscreen)

(global-set-key (read-kbd-macro "M-s") 'query-replace-regexp)
(global-set-key "\C-x\C-r" 'revert-buffer-no-confirm) ;; remap revert buffer
(global-set-key "\C-x\M-r" 'rename-file-and-buffer)

;; map start of file and end of file commands to nicer key combos
(global-set-key (read-kbd-macro "M-[") 'beginning-of-buffer)
(global-set-key (read-kbd-macro "M-]") 'end-of-buffer)

;; remap dynamic expansion to escape
(global-set-key (kbd "<escape>") 'dabbrev-expand)

;; set indent levels
(setq default-tab-width 2)
(setq js-indent-level 2)
(setq js2-indent-level 2)
(setq cssm-indent-level 2)
(setq css-indent-offset 2)
(setq ruby-indent-level 2)
(setq java-indent-level 2)

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
;; (require 'tramp)
;; (setq tramp-default-method "scp")

;; (set-default-font "-*-bitstream vera sans mono-*-*-*-*-*-106-*-*-*-*-*-*")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((((background dark)) (:foreground "#FFFF9B9BFFFF")) (t (:foreground "DarkGreen"))) t)
 '(diff-changed ((((background dark)) (:foreground "Yellow")) (t (:foreground "MediumBlue"))) t)
 '(diff-context ((((background dark)) (:foreground "White")) (t (:foreground "Black"))) t)
 '(diff-file-header ((((background dark)) (:foreground "Cyan" :background "Black")) (t (:foreground "Red" :background "White"))) t)
 '(diff-file2-hunk-header ((((background dark)) (:background "#000088"))))
 '(diff-function ((t nil)) t)
 '(diff-header ((((background dark)) (:foreground "Cyan")) (t (:foreground "Red"))) t)
 '(diff-hunk-header ((((background dark)) (:foreground "Black" :background "#05057F7F8D8D")) (t (:foreground "White" :background "Salmon"))) t)
 '(diff-index ((((background dark)) (:foreground "Magenta")) (t (:foreground "Green"))) t)
 '(diff-indicator-added ((((background dark)) (:background "#003300" :foreground "#fff"))))
 '(diff-indicator-removed ((((background dark)) (:background "#550000" :foreground "#FFFFFF"))))
 '(diff-nonexistent ((((background dark)) (:foreground "#FFFFFFFF7474")) (t (:foreground "DarkBlue"))) t)
 '(diff-removed ((((background dark)) (:foreground "#7474FFFF7474")) (t (:foreground "DarkMagenta"))) t)
 '(js2-external-variable-face ((t (:foreground "white"))) t))

;; add bash completion
(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)

;; smex
;; (smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; enable ido mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(fringe-mode '(5 . 0))

(setq-default cursor-type '(bar . 1))
(set-cursor-color '"#FFFFFF")

(set-frame-height nil 50)

;; add spell check
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

;; add undo tree visualisation
(require 'undo-tree)
(global-undo-tree-mode)

(setq split-height-threshold 99999999999999999) ;; make emacs only add vertical split panes

(setq org-src-fontify-natively t)

;; don't use OS X's native fullscreen
(setq ns-use-native-fullscreen nil)

;; do automatic wrapping of comments
(require 'newcomment)
(setq comment-auto-fill-only-comments 1)

(write-code)
