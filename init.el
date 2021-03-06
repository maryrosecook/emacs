(require 'package)
(add-to-list 'load-path "~/.emacs.d/src/packages/")
(add-to-list 'package-archives
    '("marmalade" .
      "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'mustache-mode)
(require 'rjsx-mode)
(require 'flow-js2-mode)
(setq auto-mode-alist (cons '("\\.js" . rjsx-mode) auto-mode-alist))


;; pastable snippet manager
(require 'yasnippet)
(setq yas-snippet-dirs '( "~/.emacs.d/snippets" ))
(yas-global-mode 1)

;; force helm to appear at bottom and not hide any splits
;; Instructions for use: https://github.com/wasamasa/shackle
;; Some buffers hide their name (eg Icy+ buffer below). Try modifying the buffer
;; and emacs might show you its name.
(require 'shackle)
(setq helm-display-function #'pop-to-buffer)
(setq shackle-select-reused-windows nil)
;; (setq shackle-default-rule '(:regexp t :align t :ratio 0.3))
(setq shackle-rules
      '(("\\`\\*cider.*?\\*\\'" :regexp t :select nil :shackle-select-reused-windows t)
        ("*grep*" :shackle-select-reused-windows t)
        ("*helm projectile*" :regexp t :align t :ratio 0.3)
        ("*Completions*" :regexp t :align t :ratio 0.3) ;; Icy+ buffer
        ("*Helm M-x*" :regexp t :align t :ratio 0.3)
        ("*helm buffers*" :regexp t :align t :ratio 0.3)
        ("*helm find files*" :regexp t :align t :ratio 0.3)
        ("*Backtrace*" :shackle-select-reused-windows t)))
(shackle-mode)

;; load paths
(add-to-list 'load-path "~/.emacs.d/src/")

(add-to-list 'custom-theme-load-path "~/.emacs.d/src/themes")

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'load-path "~/.emacs.d/src/vendor/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Mxajor mode for editing Ruby code" t)
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; typescript
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  )
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(use-package tide
  :ensure t
  :config
  (progn
    (company-mode +1)
    ;; aligns annotation to the right hand side
    (setq company-tooltip-align-annotations t)
    (add-hook 'typescript-mode-hook #'setup-tide-mode)
    ;; This is way too slow.
    ;; (add-hook 'before-save-hook 'tide-format-before-save) ; formats the buffer before saving
    (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  ))
;; Use tide as a nested mode in web-mode for .tsx files.
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))));; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; We need a custom tsserver-locator function.
(defun my-tide-tsserver-locator ()
  "Locate the nearest relevant tsserver."
  (or
   ;; I don't know why tide doesn't do this by default.  Maybe I should send a PR.
   (let ((typescript-dir (concat
                          (locate-dominating-file default-directory "node_modules/typescript")
                          "node_modules/typescript/lib/")))
     (tide--locate-tsserver typescript-dir))
   ;; Fall back to tide's default locator function.
   (tide-tscompiler-locater-npmlocal-projectile-npmglobal)))
(global-set-key (kbd "C-c c") 'company-complete)

;; rebind M-p to query replace in markdown mode
(add-hook
 'markdown-mode-hook
 '(lambda ()
    (define-key markdown-mode-map "\M-p" 'query-replace-regexp)))

;; web-mode for jsx
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))

;; force web-mode content-type as jsx for .js and .jsx files
;;(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

;; unite kill ring and system clipboard

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; highlight the line that the cursor is currently on
(global-hl-line-mode 1)
;; (set-face-background 'hl-line "#132d48")

;; markdown mode with support for other langs
(setq load-path
      (append '("~/.emacs.d/polymode/" "~/.emacs.d/polymode/modes")
              load-path))

(require 'poly-R)
(require 'poly-markdown)

(require 'dash)

(add-to-list 'load-path "~/.emacs.d/src/powerline")
(require 'powerline)
(powerline-default-theme)

(defun visit-ansi-term ()
  "Create or visit an `ansi-term' buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (ansi-term "/bin/bash"))
    (switch-to-buffer "*ansi-term*")))

;; allow toggling between line mode and char mode in ansi-term using C-x C-j
(global-set-key (kbd "C-x C-j") 'jnm/term-toggle-mode)

(defun jnm/term-toggle-mode ()
  "Toggles term between line mode and char mode"
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

;; make ansi-term have infinite buffer size (scrollback)
(add-hook 'term-mode-hook
          (lambda ()
            ;; support M-left M-right in ansi-term for moving/deleting word by word
            (defun term-send-Cright () (interactive) (term-send-raw-string "\e[1;5C"))
            (defun term-send-Cleft  () (interactive) (term-send-raw-string "\e[1;5D"))
            (define-key term-raw-map (kbd "M-<right>")      'term-send-Cright)
            (define-key term-raw-map (kbd "M-<left>")       'term-send-Cleft)

            (setq term-buffer-maximum-size 10000)))

;; Make C-u equivalent to C-x (for my dvorak keyboard)
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

;; peg mode
(autoload 'peg-mode "peg-mode" "Mode for editing PEG grammar files" t)
(setq auto-mode-alist
      (append '(("\\.pegjs$"    . peg-mode))
              auto-mode-alist))

;; ;; clojure mode
(add-to-list 'load-path "~/.emacs.d/src/clojure-mode")
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\.clj$" . clojure-mode))


(add-to-list 'auto-mode-alist '("\.cljs$" . clojurescript-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#3A3A3A" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DFAF8E" "#E6D7A8" "#396e89"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("9c993473c05ab119e2007d4970d7b840813243f285d93a29929eb9447abdeef8" "5f93995cc8482254ce93146312df166ff4415d76d7343e75e3ea4ba5e3feafa4" "91da4a73419ba3dcfd8699478c62f9939f486ed2be8319db2735dc605fd10999" "c266a6b486525173aa46b62e01a0a14cfa568bcbd538866f01726c644f0ad257" "e21d95c7bd5e347e6dbb58667f9fb1245053fff0d8aeca6ebb9a0957916bd81b" "88f44fa23d357e9ed7362193334c8e68d39a0025ce443cc89422e3b032cc421d" "981b7750aac1502985316bd8d6d3281f6824bb8afc2bd0d5c365346f329052f2" "50f1a602e3477baa92bdc54cd962d9be736b13f50a7d9ced33f9c9e1e491d95f" "5d56c74bfd8263b003ac9c6bc9d44e50ba5b9caf09a3a912438c7ee7fdfc2c06" "5deb71d02dda99476ff15d513c80473fd003e75d16cb39d0bde8f094cbb6aec6" "5791f2732eff735a1e0d96242e0c9e3dbb30a1c8ab627759d2e0387e25c281c3" "cd4452ce99f6608bd2da22effbcd3f11976d721fafc37814124b5edd79bfc725" "a5340c2f605314a9f474c123fc2702d2726f0347bc3ce1fb2037caedaab0750c" "79c19d1251bf8eed5d14ca0d38c91dde528ce10a88c41fd26688150bd8f63b96" "36d2ce4aba4ffa1bd93aa8fc57c16d6675572d426c5f9d1af0f5e271ad78ed7f" "ccf72a005ed784f2d225f5a2853de46387bdc98a2448c3bbd34019a12c103903" "960c529eec1fc6b8e43d0f3fbb3c5d4941dff1f2d89363bdf97346cccaf51d64" "93e85c9a3b718d33d5189646a1733fab7e72f06c3a3ef611c1b334f2806fe0b9" "5fe027bcffe1d747fe83f821f8cd875826840333f9d0ffce5df6f924e9c42db6" "5a6833a626ae1d465ebdae9668b22722aeb21728048477a9f7e73fc914938e1c" "5ad44e4a8553aa29d7f18190e9166861c8d222a1ac1091109547edcb19c0b23d" "3ce23250de157428668d1b88c00c64650ab14e68c19a87099faf855f4c1bf03d" "f1ac7b5649d2f1462624c9f73b3e0d303197ea912cfa6512ec3559ad7baca03f" "cca0052cc5a18cda12c368375df5479feaafa377cdd05f689ba7369fbd3c98c6" "9600be564fc0eae854562288692f97b549186c560c8c80c600c4b25e93b1795b" "aa64d7b9ea47b0d3a2b5bada58be8f1df51f9cd6b4a19d9c0e7e8c5a6d717f69" "6c61c0860e4c6abd2411432095c8b54a20b424f52a7069d996b32f7678d842f4" "246db2e762875637c91b8b71250600f85d605aa93cba4778baf629ec9fbf1eb7" "9cf2e24b5f28ea3452b1c25cfd0344a74b1be2803955995809d5e627d3a851bf" "d321c921925368a3a42dab0b0419a46935fd43daae9d74cf14cc289bd0d5dbf4" "d1e039404809d0e2edf142e89ec0748bc3a9aa2d52f5476b6297ea9e01219f65" "de9aec9ded417fd26a8820549a6acdce5386b4162a4f007086fd0035a69aa3e8" "de5b176bc8f3f07210ef4388ad1b767968bbea84107f74a0d90306baa2cf92b6" "db38b22054ec0c748e7295aacff5b5f8117ab32f9ec5b19d8718b3beedd4955c" "90efc05f3373a85687f59442a5b118a395db717a723fd4086c44eea2898ed033" "ae33ee26b8356f8ebade56006871f82febdf70a26e45d07c7476350b75c1c37a" "a6957099e8f0b3a4d9af3e0fce4d7bf1dad7838f72ea22ebaa238fb88b79e73c" "e68c822722f59f16dab61db67591accfbc7ea7c7c6f7dc2335ba4c0d0f9a870c" "b5c6896ce078041ac12f21d237bdcd1b197a45dd3fdd49018079fa21ea0863a9" "9868c60b48089ee00d82fb6b4ad83202fd3b8e6e139ee0eed9055f1a42ab3c1a" "a7cce494936977503ec390ae460c750cef470cbb70c02633110d3aa06ee5a62a" "7c1b0b85786691825a9b0ce169dd1f9b5d0882991d091ef3545dee32587291b4" "26bcc8d6b1f78c47de2b1063b0c883344be887ae67db485bad0ec530058bcf41" "2eae43bf18676f85982b149ed342cec3659a3f271574378839a8c7d7ea530531" "fc2cded725409e23700795ef7937c8c7304aac0b4028674cc9db846bd069d734" "4a46408f31c8b1251a25e0b1e6090c71e9cd27e790b7cb963aac2e717e628054" "6bd1fc87d11020d85e1a5ece16662633b34eb0dfe4e22a6ebb3a10d60d329cfb" "92b0ec94f06526ec006ab7fcbf8b48a57f135d6f36692e6e1abd83d38d11dcc3" "b5a8c970fcdfe03d5b76de8d168b92e6f75efd7788920f072e37e611a8e0f806" "3bca96813637d4324ea73a4aac368598f9cde2c0b9e34c7711feb03aa569c202" "e1abeea834fdb7bf62f477796acbc6b5ef950408e4cd82dcd4767e67f6239c92" "8960dc58a87948931f740ee9c9a97c964b0b553386b9dc5b4424cbdaa50d9259" "a33789ce9a7c77c9ef77136209c1355a0dccf2067b38f9c10015d914a108a952" "56f836fd091323daeb9f3bc338a9c16f384de3fd20d6dcac4f8fda5d4e16904b" "b0d92d6f280328e6710ed24fe4e2da07d4d00dd4a70e7dd5dd4ad907ceb1c3f3" "048d3b0e90e3ccb50ce94fa0d04bff508f1b39c69496ae0e1e54cfaeb7e86bb7" "e7fcc22ecfc8eb70d2e30eaaad099f9b6c6ab6536631fad9341bf407225fcdd4" "61d1a9aa38239a5dd01c07292107cc0bfadb327be6b3371b538eafffda81df6f" "bf8c3bbc91380785cc6e78d44bd6a6d61e43aee5a31df488ce7c28fb8685488c" "cdb80b8e43819a77da5a1f224cb198d86fad63beeb73ac393070226b02210d28" "693052328686ddd7c8e945396e4a975e2e95e8293933d5b306cc0c889af63277" "d0492af25ff12676c3a29e64d728dbb54068e28cb50073cca244ae3e8e815029" "b1eed80ce83ca5a2583b13037b450ff7494bfddc0a58016704133b8f3bed67ba" "d3f58e773d99b7154b51af1e42cbf14a6a57d21831d7d4ce4d16d8910347c230" "cb183bd04319dbd9f9a8bd17f737dc67958a18cff1b988ac32c16114debfa127" "51a67968abaed4433069d2c25e001431123e0823bea994aabbba59be2448b0bb" "85e6f8280e97c48f697580550b5d4ebf958d9242e8d4e545a9936aaf697bf139" "bac3067cf3bd4a75fca1ca027c9b66b618b236bdfec25c1a86a3cc3752ec7f63" "cf35d8d2bc303298c68dcf2bf2f69517552b339343cb0c1a4a607fd1e3d968ba" "4b483205beb5fb5e6224de78284b4549615437702983b908817486cd5d3861fc" "9e9eef9cb04a7a1e07b5a2a6995bf4cb57cdbf7f9de961f5885f43c0ec5c08ba" "24c1b6ce181315a6399de4b1bb0719c6c02d82a37ca5ad56f30808536e8e2631" "1cf6234303f2c5eb65df6e874016908e2f16cf351ae0bbb39dbe747d877f829b" "530f872ab85e9367a873cd305158ffa97bd895b4887d70ddf057faaf20ba408e" "7b40b7bd815a8a2f2abf22ab6740ae4e4b285d618cf844096880ab14d861949d" "1ca66007bf34db2674872e4f5f02b35432b3b7b09838fe79492f982b8aac0853" "9bde6e4312f47e44416aa50e4a64b331a9ee53aa757706b11e31ea4764561ef8" "5e72ce338507a7ee316f568d9c626641438a0341201b70702126242a41e2137a" "fbc168238218fddef5e7a30a6d3e03d87cc84a3afd343cccb2fa2917d84ba035" "d6e7f9a0b2325c982cfa737fd7c787bb1ce48d034c91ea0784474042562eef99" "88350417231115eb3052c665d9fecfbf455dd3b4e1ce9edc4932c059c71bf460" "e45f571d1ba7a0c713f7d2219c88ba0b2e166d375896f314dc64874d4cff06eb" "7ea3d0ee4b39a5f014ceb31de6e6ebf57e1727d07d9f20953cc71daa3e3f3628" "0235a04f9bdb183cde6fdf6b59b5a03460f405b9d0fb5c812b520748261647fa" "e80bb585b82e76197750b66577f48285e1e87d80d4492ed7eb7f9ec4859144bd" "6f83e3b6d76872caa68dfc1c4fc2405cf0a5fe82f08e7e8b5bf6cacffac893da" "a5081b0e01edb999499fbfac769491f5e4ae104234d7fb815fe66e8d60b5eb4f" "ce1b4eaef870501122ac2dfe95696ce64e1ff3092fd3430178a8255893164a52" "927fc0fa111ab678e4accccd0e4242edebf9c40d51e46015b79ef9617ffe18ee" "1ccf07bb8c3ed854feefebe70298c5ae0760729557fad01e3d22998bc7f2e531" "1486b48c6e73a0a6d9e3b32b36d8833ca4ccb8e027a00488880278f7f0192d8e" "a8bfc49d1c322ebe7cfc3ee8c9bd1e4a5aa4ddb99cedfa4ab5ece09dcc96274a" "16c3ec90a4d3c0a844571c985b93b6f429a65b232c298fbd1993b3a35efb694b" "20c90123ee7110965d5bf8ec53d2f27511e930b9e1b39b4683307208d3298402" "a51143a9e631e2c9276441ec07aab32624c55584f344563a432712790f992944" "b094a7733a4bb012f4db2156da367d58a76527a0df3221aa2eda63ebb0b273f9" "e97b61b2edf3a0c1dfe956ca70e9215b4aa209a4f7ae14bf43a4c966ac0005ef" "a2bf86525e04d9307a2a2780795cfcf0cdb90c8be81804535a8c6336f2dc0c50" "7aa99ac45f4c9c9f7840ea9eca6143ea67545e0ada2a71edff067687ac7dc310" "b3370762e3bc3a0f45271887127681b4dbb8f9d4692b9a4106a62671036a65be" "29113cf8d08a131ddc86da03761b6a91dd106661adc0b29046923e886c479c47" "f36ded2d4aee8b7b7d55dd207c9df69ff8122e2d8154329cfa0413c42fc0bb9d" "e45a5b5451fb361629d90e96423bcc94997f29abbe47d2ef3afad2f0f66c6e68" "54f1d13ab09052af986af3fcd5e40be7f678fc208dff6e6371e8d276ee170000" "76630da4126a48e5f2863154e8a00375cbf01817ad42d2b5e7fbb80a97b89b85" "2cd55ad874da0d900d256952544d708caf263e31263d2e4f53f4deafc1432cf3" "66c5e558bc689e6a0f4a9d43d7377084e468d337060597d22f91e8fec4d18fa3" "23478554272446b0f1ee23727a70a41ec3b28c8ec128f1102b2ce4c3cfa37b8f" "96b29427858d25f264d2bb1027b7c51fbcd7cfbee002d6062ad471d39a1ea688" "e33660a8a6e9fd9e6a808d1eb3b3c1cce5e7b0f442bf4c5841ba3f7ce3681cb5" "0b6fea5e6c6e3e17a8512fe1dd346d561b241a4a0fe3eab83b18d624d8a10b4f" "339cb47398a7d149738c8edfbd9e5f335645dbe9844d041d1eca8889f6735490" "eaaed141610247b040b0e6b206d0c5ff51e5cb08d2fe47bf19d31c343287f1f8" "8762b4413b22adb5f264005707ce3bff09ab5a579381bf4cb96ea41085c84d43" "0ea83aa487f6d23f7314fa2d2ba64e3758ccd825d9a00256d69f275eb08e882e" "5068910bb6282ebf77140149e99549a153d5072f0f4b043970d94a0064935905" "13c467ecc86b60f172fb70131ad3c82c64262f1c7e8eea7d1dd01d05ef567081" "445a08e3e9eceee24308455afab7b9453b3c4ae9c4b8894c79e49b0ec16c8106" "dd4257c3c96aecf6ced3f3edd47c7873c25be752911c9b7ec85ef5f2343afc7a" "ea4b71aed907b0e5680a24c38f0586d8935b2f48d02b64d500287072029e4c6d" "dbe7739c04d909c5104be21918346bafe37a819c89a4be99463feb0b1eb41b0b" "f69807932b357250029225b5c767c4a7a23e589d966df54fd111be4ff30c8221" "f39d7ea259a4a0a56d2d9209d5d6e0dd845189566abd4f6c3b8ce72fa3922c69" "734379032c184589a2d5d31d3693b89313fbae41ed783d3d6e5503b71dd7aefa" "564a8970aecf0b0e6ddcfdae48bf9ccec06649e6dea3d2b7d0be00addcd80f64" "4107b88ae6910631777dd6168f2884fb1d24cb6d17fcab474c9855d4a1bafcf5" "41dd6eb6db8a90823afef45ee97a0d778f1d9e0c335358bbdbce6aa31c0fca62" "bb36206a9b8e65ad4567c7fdc980dfbe16be119b74d003b5488a44cf9c8dde78" "986d0d33bf7fc5a92782a472138be29a60118365c320d62a457c6d1571cd5347" "c64a2a47f2f52dd14272bfda12b58e1728017b51988c0ce7f2e9a73e514b9fc5" "7ddc682ffbf47f3d72c73934aed76a6c8b3ba825c2de054ead8fcb5567be0419" "9679c97a7b1d83aeb353a04a195c47c4e9c418c0f09ba58bda95cf61f6fddb3f" "4a16389e4c5a7aae7def3481a7d5b72baf10338cbec70a65d94d0053fd405284" "03c2b94e263872fa8ebfba3212e570fe98a7234106850bbc4005dbf65f502556" "d9a06d7fef64ddcba2ea99cc7a9776e7610da107eb90cf6e47c575cc90202992" "7b67c9ecf49d51bf0bb5023396b654f4bdc0e5edfc4293e1c43c3a67dfc2bcf6" "39675bfa23d2a8d22cf5fcc6bd43ff994ff7a01b1d6cfe63467f0f719353d3a6" "dd4a7572e973ae7d55ec3f4bf4eba7c6d9bd8dad064c83ceac60111177c06d3e" "0b542d959c3fcf9b60e6c996c83b795467c810b4de4530630455fa01cf165011" "f406880d8dcae49ac59e761fd87f1383669d77af808c58045f6928a93b5c91a4" "bab3e0ad7efa4f66e52856942c306525cf37a34b8766d0b0168675be04fc4ecd" "c6dbf623f993fedbb3c818baaf869861bb5508234565a3207467138f479ada27" "ecf2117376dbff750d0304af6b5463851d9c4547b80f927dba338529f86be72c" "aecea99f23d116cd33dabe34b9df808816c374328c064fcf12d15cecc3735237" "a8f418590d565a3d79b17d018583161e5a0d4ae1a46213031c2c3c707da9a13d" "8f5bf150ef38ccee3caf3b3053fe467508d8fc903d5550625da9e0a9f8d66a4d" "5a8075cca0bfb4910d8249738c50413edc634179310d4c34a24c57aa0c81f9bc" "062bd6c2212804229ec2749448acf13d0a76d9703cc706505302e367646f2dce" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "5d1434865473463d79ee0523c1ae60ecb731ab8d134a2e6f25c17a2b497dd459" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "3527fd78ef69e7f42481e6de5bf7782b5552a88bfe2a600cf9734b7a6d89b33f" default)))
 '(fci-rule-color "#383838")
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" ".happypack" "transpiled" "web_service/public/js/build" "coverage" "node_modules" ".cache" "web_service/public/css/compiled" "build" "flow-typed" "compiled" "declarations" "worker_service/test/test_files/generated" "server_shared/test/fixtures/explore/snapshots")))
 '(helm-M-x-fuzzy-match t)
 '(helm-autoresize-min-height 40)
 '(helm-autoresize-mode t)
 '(helm-buffer-max-length 50)
 '(helm-buffers-fuzzy-matching t)
 '(helm-ls-git-default-sources (quote (helm-source-ls-git)))
 '(helm-ls-git-fuzzy-match t)
 '(helm-ls-git-show-abs-or-relative (quote absolute))
 '(helm-mode-fuzzy-match nil)
 '(helm-reuse-last-window-split-state nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(icicle-Completions-display-min-input-chars 2)
 '(icicle-Completions-max-columns 1)
 '(icicle-Completions-text-scale-decrease 0.0)
 '(icicle-S-TAB-completion-methods-alist (quote (("apropos" . icicle-apropos-match))))
 '(icicle-default-cycling-mode (quote prefix))
 '(icicle-incremental-completion (quote always))
 '(icicle-incremental-completion-delay 0.0)
 '(icicle-incremental-completion-threshold 1000)
 '(indicate-buffer-boundaries nil)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (js-import company use-package tide rjsx-mode js2-mode flow-js2-mode indium fill-column-indicator prettier-js clojurescript-mode clojure-mode cider zenburn-theme zenburn yasnippet xclip web-mode tangotango-theme solarized-theme smex shackle polymode mustache-mode monokai-theme helm-projectile helm-ls-git gruvbox-theme fringe-current-line flx-ido elm-mode color-theme-zenburn color-theme-sanityinc-tomorrow color-theme-railscasts color-theme-github auto-complete ample-zen-theme afternoon-theme)))
 '(prettier-js-args (quote ("--tab-width=4")))
 '(prettier-js-width-mode (quote nil))
 '(tide-completion-detailed t)
 '(tide-node-executable "/Users/mary/bin/node-activated")
 '(tide-tsserver-locator-function (quote my-tide-tsserver-locator))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BA")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(wakatime-api-key "202c62a3-a440-4bec-b844-a58d4ff97980")
 '(web-mode-attr-indent-offset 4)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

;; vc-diff colours
(require 'diff-mode-)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat "tmp/places"))

;; projectile - open file in project
(require 'projectile)
(projectile-global-mode)
(projectile-mode 1)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-o") 'helm-projectile-find-file)

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
(global-auto-revert-mode t) ;; was causing errors on startup - now seems OK

;; automatically add newline to end of files on save
(setq-default require-final-newline t)

;; no newline for snippet files (would add newline to inserted snippet)
(setq snippet-mode-require-final-newline nil)

;; turn off scss auto compile on save
(setq scss-compile-at-save nil)

;; smooth scrolling
(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq scroll-step 1)
(setq scroll-conservatively 10000) ;; scroll by cursor move amount when move cursor past top or bottom of window

;; multi web mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((js-mode  "<script[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("htm" "html" "erb"))
(multi-web-global-mode 1)

;; Standard Emacs functionality
(setq-default indent-tabs-mode nil)
(setq-default inhibit-startup-message t)
(setq-default next-line-add-newlines nil)
(setq-default require-final-newline nil)
(setq-default scroll-step 1)
(menu-bar-mode 0)
(column-number-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; removed for command line emacs
;; (tool-bar-mode 0)
;; (scroll-bar-mode 0)


;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(setq backup-directory-alist '(("" . "~/.emacs-file-backups")))

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
  (cond ((string= (current-major-mode) "clojurescript-mode")
         (progn
           (insert "(.log js/console (clj->js ))")
           (backward-char)
           (backward-char)))
        ((string= (current-major-mode) "clojure-mode")
         (progn
           (insert "(println )")
           (backward-char)))
        (t
         (progn
           (insert "console.log()")
           (backward-char)))))

(eq (current-major-mode) "a")

;; Inserts "use strict";
(defun insert-use-strict ()
  (interactive)
  (insert "\"use strict\";"))

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
         (name (get-next-scratch-file-name dirs 860))
         (name (read-string "File name: " name)))
    (if (string-match "[.]+" name)
        (new-buffer-with-ready-file code-dir name)
      (new-buffer-with-ready-file text-dir (concat name ".txt")))))

;;enable company mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; narrower window, better line wrapping for prose
(defun write-words ()
  (interactive)
  (setq line-spacing 2)
  (visual-line-mode t))

;; widescreen, no line-wrap
(defun write-code ()
  (interactive)
  (show-paren-mode 1)
  (disable-theme 'adwaita)
  (load-theme 'zenburn)
  (set-cursor-color "#ffffff")
  ;; removed for command line emacs
  ;; (set-frame-width (selected-frame) 80)
  ;; (set-frame-height (selected-frame) 66)
  (visual-line-mode 0)
  (setq line-spacing 0))

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

;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

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

;; save a list of open files in ~/.emacs.d/.emacs.desktop
;; save the desktop file automatically if it already exists
;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-save 'if-exists)
(desktop-save-mode t)
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

(global-set-key "\C-x\M-f" 'new-scratch-file)

;; removed for command line emacs
;; (global-set-key "\C-x\C-z" 'visit-ansi-term)

(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-t" 'recenter-top-bottom)
(global-set-key "\C-z\C-x" 'shell-command) ;; shortcut for shell command
(global-set-key (read-kbd-macro "C-x g") 'rgrep)
(global-set-key (read-kbd-macro "C-x l") 'insert-print) ;; insert console.log()
(global-set-key (read-kbd-macro "C-x w") 'write-words)
(global-set-key (read-kbd-macro "C-x c") 'helm-grep-do-git-grep)
(global-set-key (read-kbd-macro "C-x t") 'toggle-frame-fullscreen)
(global-set-key (read-kbd-macro "C-x s") 'insert-use-strict)
(global-set-key "\M-p" 'query-replace-regexp)
(global-set-key "\C-x\C-r" 'revert-buffer-no-confirm) ;; remap revert buffer
(global-set-key "\C-x\M-r" 'rename-file-and-buffer)

;; make forward-word and backward-word match OS X
(global-set-key "\C-\M-b" 'backward-word)
(global-set-key "\M-b" nil)
(global-set-key "\C-\M-f" 'forward-word)
(global-set-key "\M-f" nil)

;; I use C-M-f and C-M-b for cursor navigation (see above).  Unmap
;; these combos from ops I don't use in markdown-mode
(add-hook 'markdown-mode-hook
          (lambda()
            (local-unset-key "\C-\M-b")
            (local-unset-key "\C-\M-f")))

;; Use Helm for emacs execute command
(global-set-key (kbd "M-u") 'helm-M-x)

;; Use helm for find file
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; Use Helm for buffers list
(global-set-key (kbd "C-x b") #'helm-buffers-list)

;; map start of file and end of file commands to nicer key combos
(global-set-key (read-kbd-macro "M-[") 'beginning-of-buffer)
(global-set-key (read-kbd-macro "M-]") 'end-of-buffer)

;; remap dynamic expansion to escape
(global-set-key (kbd "<escape>") 'dabbrev-expand)

;; js2-mode settings
(setq js2-strict-inconsistent-return-warning nil) ;; prevent warning for fn that has something like `return` and `return aValue`
(setq blink-matching-paren nil) ;; speed up
(setq js2-strict-missing-semi-warning nil)
(setq-default js2-global-externs '("module" "require" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "__dirname", "fetch", "process"))

;; prettier - code formatting
(require 'prettier-js)
(defun maybe-use-prettier ()
  "Enable prettier-js-mode if special file exists."
  (if (locate-dominating-file default-directory ".pprettierrc") ;; call it pp to avoid enabling prettier across all of Hyperbase
      (prettier-js-mode +1)))

(add-hook 'typescript-mode-hook 'maybe-use-prettier)
(add-hook 'js2-mode-hook 'maybe-use-prettier)
(add-hook 'rjsx-mode-hook 'maybe-use-prettier)
(add-hook 'web-mode-hook 'maybe-use-prettier)

;; set indent levels
(setq default-tab-width 4)
(setq js-indent-level 4)
(setq js2-indent-level 4)
(setq js2-basic-offset 4)
(setq rjsx-indent-level 4)
(setq cssm-indent-level 2)
(setq css-indent-offset 2)
(setq ruby-indent-level 2)
(setq java-indent-level 2)
(setq elm-indent-offset 2)
(setq web-mode-markup-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq sgml-basic-offset 4)

;; elm
(require 'elm-mode)

;; can't remember what this does
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; pipe down
(setq bell-volume 0)
(setq sound-alist nil)
(setq ring-bell-function 'ignore)

;; set ansi-term program to bash
(setq ansi-term-program "/bin/bash")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3A3A3A" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(diff-added ((((background dark)) (:foreground "#FFFF9B9BFFFF")) (t (:foreground "DarkGreen"))))
 '(diff-changed ((((background dark)) (:foreground "Yellow")) (t (:foreground "MediumBlue"))))
 '(diff-context ((((background dark)) (:foreground "White")) (t (:foreground "Black"))))
 '(diff-file-header ((((background dark)) (:foreground "Cyan" :background "Black")) (t (:foreground "Red" :background "White"))))
 '(diff-file2-hunk-header ((((background dark)) (:background "#000088"))))
 '(diff-function ((t nil)))
 '(diff-header ((((background dark)) (:foreground "Cyan")) (t (:foreground "Red"))))
 '(diff-hunk-header ((((background dark)) (:foreground "Black" :background "#05057F7F8D8D")) (t (:foreground "White" :background "Salmon"))))
 '(diff-index ((((background dark)) (:foreground "Magenta")) (t (:foreground "Green"))))
 '(diff-indicator-added ((((background dark)) (:background "#003300" :foreground "#fff"))))
 '(diff-indicator-removed ((((background dark)) (:background "#550000" :foreground "#FFFFFF"))))
 '(diff-nonexistent ((((background dark)) (:foreground "#FFFFFFFF7474")) (t (:foreground "DarkBlue"))))
 '(diff-removed ((((background dark)) (:foreground "#7474FFFF7474")) (t (:foreground "DarkMagenta"))))
 '(font-lock-builtin-face ((t (:foreground "#DFB089" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "#7CB8BA"))))
 '(font-lock-keyword-face ((t (:foreground "#E6C7A8" :weight bold))))
 '(font-lock-type-face ((t (:foreground "#7CB8BA"))))
 '(font-lock-variable-name-face ((t (:foreground "#DFAF8E"))))
 '(hl-tags-face ((t (:background "#505050" :weight bold))))
 '(icicle-Completions-instruction-1 ((t (:foreground "#dcdcdd"))))
 '(icicle-complete-input ((t (:foreground "#0f0"))))
 '(icicle-historical-candidate ((t (:foreground "#dcdccc"))))
 '(isearch ((t (:background "#8C5353" :foreground "#D0BF8F" :weight bold))))
 '(js2-external-variable ((t (:foreground "#CC9393" :weight bold))))
 '(js2-external-variable-face ((t (:foreground "#CC9393" :weight bold))))
 '(markdown-header-face-1 ((t (:foreground "#E6C7A8"))))
 '(markdown-header-face-2 ((t (:foreground "#E6C7A8"))))
 '(markdown-header-face-3 ((t (:foreground "#DFB089"))))
 '(markdown-header-face-4 ((t (:foreground "#CC9393"))))
 '(markdown-header-face-5 ((t (:foreground "#7F9F7F"))))
 '(markdown-header-face-6 ((t (:foreground "#7CB8BA"))))
 '(minibuffer-prompt ((t (:background "#8C5353" :foreground "#fff"))))
 '(mode-line-inactive ((t (:background "#2B2B2B" :foreground "#fff"))))
 '(powerline-active2 ((t (:background "#8C5353" :foreground "#fff" :weight bold))))
 '(region ((t (:background "#8C5353"))))
 '(show-paren-match ((t (:background "#5F5F5F" :weight bold))))
 '(vertical-border ((t (:background "#3A3A3A" :foreground "#5A5A5A" :inverse-video nil)))))

;; Reverse colors for the border between buffers to have nicer line
(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?┃))

;; add bash completion
(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)

;; enable ido mode
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'hl-tags-mode)
(add-hook 'sgml-mode-hook (lambda () (hl-tags-mode 1)))
(add-hook 'nxml-mode-hook (lambda () (hl-tags-mode 1)))

;; removed for command line emacs
;; (fringe-mode '(5 . 0))

(add-hook 'window-configuration-change-hook
          (lambda ()
            (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 1 1)))

(setq-default cursor-type '(bar . 1))

;; removed for command line emacs
;; (set-frame-height nil 50)

;; add undo tree visualisation
(require 'undo-tree)
(global-undo-tree-mode)

(setq split-height-threshold 99999999999999999) ;; make emacs only add vertical split panes

(setq org-src-fontify-natively t)

;; don't use OS X's native fullscreen
(setq ns-use-native-fullscreen nil)

;; DEL during isearch should edit the search string, not jump back to
;; the previous result
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

(global-set-key (kbd "M-\\") 'dabbrev-expand)
(global-set-key (kbd "C-/") 'undo)
(global-set-key (kbd "M-/") 'redo)

;; stop emacs splitting to more than two windows

(setq split-width-threshold (- (window-width) 10))
(setq split-height-threshold nil)

(defun count-visible-buffers (&optional frame)
  "Count how many buffers are currently being shown. Defaults to selected frame."
  (length (mapcar #'window-buffer (window-list frame))))

(defun do-not-split-more-than-two-windows (window &optional horizontal)
  (if (and horizontal (> (count-visible-buffers) 1))
      nil
    t))

(advice-add 'window-splittable-p :before-while #'do-not-split-more-than-two-windows)

;; for Airtable file formatting
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  ;; Do not line up indents in various situations; standard indent is fine.
  (mapc
   (lambda (indent-situation)
     (add-to-list 'web-mode-indentation-params
                  (cons indent-situation nil)))
   '(
     "lineup-args"    ;; function arguments
     "lineup-calls"   ;; chained dotted calls
     "lineup-concats" ;; string concatenations
     "lineup-ternary" ;; ternary operator arguments
     )))
(add-hook 'web-mode-hook 'my-web-mode-hook)


;;

(server-force-delete)
(server-start)

(write-code)
