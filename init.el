;; load paths
(add-to-list 'load-path "~/.emacs.d/")

;; add git to shell path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/git/bin"))
(setq exec-path (append exec-path '("/usr/local/git/bin")))

;; add node to shell path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; disable annoying backups and autosaves
(setq backup-inhibited t)
(setq auto-save-default nil)

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
(show-paren-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat (user-login-name) "/tmp/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

(require 'color-theme)
(color-theme-initialize)
(color-theme-blackboard)

(require 'haml-mode)

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

;; inserts js log call and puts cursor between brackets
(defun js-insert-console ()
  (interactive)
  (insert "console.log()")
  (backward-char))

(defun find-name-file ()
  (shell)
  (end-of-buffer)
  (interactive)
  (insert "find . -name \"\"")
  (backward-char))

;; narrower window, better line wrapping for prose
(defun write-words ()
  (interactive)
  (set-frame-width nil 90)
  (global-visual-line-mode t))

;; widescreen, no line-wrap
(defun write-code ()
  (interactive)
  (set-frame-width nil 320)
  (set-frame-height nil 95)
  (global-visual-line-mode 0))

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

;; Key bindings
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-x\C-z" 'shell) ;; shortcut for shell
(global-set-key (read-kbd-macro "C-x g") 'rgrep)
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent) ;; indent previous line after
(global-set-key (read-kbd-macro "C-x l") 'js-insert-console) ;; insert console.log()
(global-set-key (read-kbd-macro "C-x w") 'write-words)
(global-set-key (read-kbd-macro "C-x c") 'write-code)
(global-set-key (read-kbd-macro "M-s") 'query-replace)
(global-set-key "\C-x\C-r" 'revert-buffer-no-confirm) ;; remap revert buffer
(global-set-key (read-kbd-macro "C-x t") 'find-name-file)


;; map start of file and end of file commands to nicer key combos
(global-set-key (read-kbd-macro "M-[") 'beginning-of-buffer)
(global-set-key (read-kbd-macro "M-]") 'end-of-buffer)

;; remap dynamic expansion to escape
(global-set-key (kbd "<escape>") 'dabbrev-expand)

(setq default-tab-width 4)

(setq js-indent-level 2)
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

;; (add-to-list 'default-frame-alist '(height . 95))
;; (add-to-list 'default-frame-alist '(width . 320))

;; tramp - /sub.server.com:public_html/foo.html
(require 'tramp)
(setq tramp-default-method "scp")

(set-default-font "-*-bitstream vera sans mono-*-*-*-*-*-106-*-*-*-*-*-*")
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:height 125 :family "Inconsolata")))))

(write-code)
(ido-mode)

;; start with the shell open
(shell)