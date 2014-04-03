(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; load paths
(add-to-list 'load-path "~/.emacs.d/")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'load-path "~/.emacs.d/vendor/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; coffeescript major mode
;; (add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
;; (require 'coffee-mode)

;; ioke mode
;; (require 'ioke-mode)

(require 'dash)

;; Make C-u equivalent to C-x (for my dvorak keyboard)
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

;; enable auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)

;; peg mode
(autoload 'peg-mode "peg-mode" "Mode for editing PEG grammar files" t)
(setq auto-mode-alist
      (append '(("\\.peg$"    . peg-mode))
              auto-mode-alist))

;; clojure mode
(add-to-list 'load-path "~/.emacs.d/clojure-mode")
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
    ("3527fd78ef69e7f42481e6de5bf7782b5552a88bfe2a600cf9734b7a6d89b33f" "d903c8447aef4cd3a4c66b965a18fdc25b718c64f764e26a09547d56702966e7" "4d6f242944f3f2707c3119ad3ec64faf5f6f56e0916823d53db362655b767bbe" "152e9e6fe1e1caa8f3927c97500c1aa673faa60518f2c14f9df72cf05e81819e" "dbd1eca1883c12b233661eaccef2e6a6c4d1e356f2be7265e6964e10bd58131f" "30f4892a1476eba37e667ee4d61eff7e0db6a6b74254b2551b36b976693f5f17" "c739ff147328c4a290e2d66c88e66e7e408c59249b53b3cedba77984a3d992ef" "4bb8b36b52047435938386dadf6b464122237510c529f088b54ea18cddfd93fe" "a17154cda66454ed83a839ad826defb9fdf8e984e66a4e1f908cc494e8b007c2" "f46c9db60a95e80650fa0dd094361ecb0b4669ae311b949fd0dcb5bc7ba44763" "f111203851bd38e84e3163958ee26845cd8cad470188a565c1b2b4ed41d0403b" "d64645be2fe83276a7bdaaff9d4b04188b9a7dd3a7e14e77089febfe0ec7d978" "544d7434608e7b1754727279113d2343281476622d52a0178de6f2ff237b8814" "f21ef039662c30235077b4bec1aaa3fc306ad34398705c705d408cf2f9feeaae" "c61a5b5169f7048a35c0920f5ca30ab9e8b11fc8ac28b59393eb8bbb27b21f93" "b282d9643248c2d67aa44fafb40d33bb96df043ca09c2bf60b8da293b3ec6b6b" "bb877d4214b47342c90017edb7c2e617d08b9a662336098db6f19831cdb4c612" "ccdae8fc59cf9513f01686b97a984af25d52463fcb3ac00d89e9150f5ea19202" "1abc774ca2a17d489311b5efb1f0e2ea3ec3ce540c6bcae6c88a45166199e5ec" "002527bc073d6002886475b3d06d7e866dd1f7a3e81e6e343e807f9d76c4319c" "75ac2cded84e96b333c6e72b17c4d508f0924c4b7aeb576add4c533f7cb6629f" "70d72e74992e2d7ef7df523d9453b002e3cb7bb5122cdcee71559d87ba0060dc" "405d2f0c9a2e820c20194a9fe956f94338a705884dcf2da2f67269bd271b0bb6" "f3725235eab91da0735c511903e3eb78888f2205e3d2c11af7f821dd2eeb6067" "2d3e8051bb8511206783f26bc3294e6bbbe84091789359d8ae3cf03c81683d40" "5144a17c5cce9a5fd35359eb484ca4e24fcccb870a81cef46b0a4fcb70ab44d9" "0c7cde9f11ff3defa575c58b2098f6d2bc7d11b66bdda0fc3ebe834665abb0d4" "8f59315a266c1a2bbdee05c6e74233defdb1481bbe0081f6fab09e598b999811" "50441a814c8e77b847da002303af8d235798ca9432ccd2e3a5ed02baa7d2985a" "0607b7b69b20184b1d26deed4516770c8438733a8bab0efce7ed8cef1e5125e3" "efe8dcbd9bfa6e08c1251a0d5b5c6e4286623a842e7c37c0b80f2fde9892c3c2" "59b24a289a3de847002013d953affd98478f9568b89147cf088637ac1daa1220" "53d38354806bf131aaa480dfb6fc9d11c0dc9446b2849ce5372192e7c7d4960f" "5dc055485914ba21a45667ea9431c51d9c117bebf81f33090a0a1d8a534c09b7" "c1810f6d0951a3b527b56e5e26795fd86d89af0af98d16e3044b014877d064d4" "cc0edbbda20716c1e2ab5a6e2f9a750cd09ba04a15fc4cc87f657a28d405916e" "8fe6e31ad7c2033f97ec624b5dab8509bca66e430fe769cf1e181f47808afce7" "a3ef63aefbecb00c5987b483137cc43e2312497348715a9dff44144328e475fc" "9c3911a8beff0c60a967905b9f5ae178b8f62bf8ebce5be5619b5cc21221937d" "1e50e1ff2d7779891a6bac2aa5446834bf44ef5368f8df25ee26b42af6888760" "81efe6e406c886e71c278720927ae9695617643f42ee704e93a771966904409e" "7c9886b27a05a1ea30c8848cc287e37f118efb5613e9a9b0703300b2e69f99d6" "942572f137fc50f58cb73bceaf1a81f80d865e7b054a5dc71d538da6b295692a" "ecb261a7afeb1cadddf0071310ebd59eacc651b4128f22bb90970ed00cbb0079" "5b13f5883ecda4a00c5f48bfa47c5bce5a4eebda848c08c332ad9c1adac6064c" "9529db2ee385266ab6a359e25629931f589d4630e296466cdf2207b0ede8809b" "16a9b6dcf2381379419e15d36c61926e4f3d8925754daa66e9e83617e8ccafdf" "7cec21763c00b258'6c5877e23ea7347f853672c57f81d61806ac8f1dc2379986" "385a4dd1c1369b5301e9c8f38e1984e9e16e0fffaf19b12a8ee9b2431c2fbab0" "fe8f0fe9e52c21a3d574d25ab1167f3372ab37e1e97478fe065c4f8015867abc" "0449a71c940c57f767774e30d7bf28b64456f431510d8cde29e86657a2602df6" "7f5f2d4376315b12a62d3edb921c62dec7884be43d268fefeac52dad7cbf9618" "4294fa1b78ee65d076a1302f6ed34d42e34f637aae918b7691835adef69bd4cc" default))))

;; add package manager
(add-to-list 'load-path "~/.emacs.d/packages/")
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

;; inserts js log call and puts cursor between brackets
(defun insert-print ()
  (interactive)
  ;; (insert "(println )")
  (insert "console.log()")
  (backward-char))

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
         (name (get-next-scratch-file-name dirs 200))
         (name (read-string "File name: " name)))
    (if (string-match "[.]+" name)
        (new-buffer-with-ready-file code-dir name)
      (new-buffer-with-ready-file text-dir (concat name ".txt")))))

;; narrower window, better line wrapping for prose
(defun write-words ()
  (interactive)
  (disable-theme 'blackboard)
  (load-theme 'adwaita)
  (set-face-background 'fringe "#ffffff")
  (set-face-attribute 'default nil :font "bitstream vera sans mono-11")
  (setq line-spacing 2)
  (set-frame-width (selected-frame) 80)
  (set-frame-height (selected-frame) 53)
  (visual-line-mode t)
  (setq mode-line-format nil)
  (show-paren-mode 0))

;; widescreen, no line-wrap
(defun write-code ()
  (interactive)
  (disable-theme 'adwaita)
  (load-theme 'blackboard)
  (set-cursor-color "#ffffff")
  (set-face-background 'fringe "#0C1021")
  (set-face-attribute 'default nil :font "bitstream vera sans mono-11")
  (visual-line-mode 0)
  (setq line-spacing 0)
  (show-paren-mode 1)

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

(global-set-key (read-kbd-macro "M-s") 'query-replace)
(global-set-key "\C-x\C-r" 'revert-buffer-no-confirm) ;; remap revert buffer
(global-set-key "\C-x\M-r" 'rename-file-and-buffer)

;; (modify-syntax-entry ?_ "w" js-mode-syntax-table)

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

(write-code)
