;; load paths
(add-to-list 'load-path "~/.emacs.d/")

;; add git to shell path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/git/bin"))
(setq exec-path (append exec-path '("/usr/local/git/bin")))

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

;; Make Emacs look pretty
;;(require 'color-theme)
;;(require 'color-theme-gruber-darker)
;;(require 'color-theme-tangotango)
;;(require 'color-theme-subdued)
;;(require 'color-theme-blackboard)
;;(color-theme-subdued)

;; I also like these themes:
;;(color-theme-blackboard)
;;(color-theme-tangotango)
;;(color-theme-gruber-darker)
;;(color-theme-subtle-hacker)
;;(color-theme-hober)
;;(color-theme-dark-laptop)
;;(color-theme-digital-ofs1)
;;(color-theme-katester)

;; Make colours in Emacs' shell look normal
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Don't auto-truncate lines in shell mode
(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))

;; Key bindings
;;(load-library "keybindings.el")
(global-set-key (read-kbd-macro "C-x M-v") 'visual-line-mode)
(global-set-key "\C-l" 'goto-line)

;; Font
;;(set-default-font
;; "-microsoft-Consolas-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")

(ido-mode)

(setq default-tab-width 4)

(global-set-key (read-kbd-macro "C-x g") 'rgrep)

;; python debugger
(global-set-key (read-kbd-macro "C-x p") "import pdb; pdb.set_trace()")

;; can't remember what this does
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; set font
;;(set-default-font "-*-bitstream vera sans mono-*-*-*-*-*-80-*-*-*-*-*-*")

;; open up two panes side by side
;;(split-window-horizontally)

;; periodically save current emacs state and restore on startup
;;(desktop-save-mode 1)

;; maximise frame
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 95))
(add-to-list 'default-frame-alist '(width . 320))
