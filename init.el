;;###############################General settings######################################
(add-to-list 'load-path "~/.emacs.d/mypackages/")
(setq user-mail-address "lichenhao.sg@gmail.com"
      user-full-name "Li Chenhao")
;;package repo
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;#######################################Mini buffer###################################
(ido-mode t)

;;#################################User interface######################################
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#657b83" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#fdf6e3"))
 '(background-color "#002b36")
 '(background-mode dark)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (adwaita)))
 '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(fci-rule-color "#eee8d5")
 '(font-use-system-font t)
 '(foreground-color "#839496")
 '(org-startup-truncated nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#cb4b16") (60 . "#b58900") (80 . "#859900") (100 . "#2aa198") (120 . "#268bd2") (140 . "#d33682") (160 . "#6c71c4") (180 . "#dc322f") (200 . "#cb4b16") (220 . "#b58900") (240 . "#859900") (260 . "#2aa198") (280 . "#268bd2") (300 . "#d33682") (320 . "#6c71c4") (340 . "#dc322f") (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "pale goldenrod")))))
;;redo-undo
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)

;;color theme
(require 'color-theme)
(setq color-theme-is-global t)
;;full screen
;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
;启动时最大化
(my-maximized)
;;line number
(global-linum-mode 1)
(column-number-mode 1)
;;highlight the current line
(global-hl-line-mode 1)
(blink-cursor-mode 0)

;;#################################User functions -- Shortcuts######################################

;;***************select current line********************
(transient-mark-mode 1)

(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(global-set-key (kbd "C-`") 'select-current-line)
;;###################################Dired file system################################
(setq wdired-allow-to-change-permissions t)

;;###################################Programming languages################################

;;*****************General******************
;;auto complete
(require 'auto-complete-config)
(ac-config-default)
;;complete file path
(setq-default ac-sources (append ac-sources '(ac-source-filename)))

;;rainbow delimiter mode
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)

;;To load templates
(add-hook 'find-file-hooks 'maybe-load-template)
(defun maybe-load-template ()
  (interactive)
  (when (and
	 (string-match "\\.py$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/templates/template.py"))
  ;; Rscript
  (when (and
	 (string-match "\\.rscript$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/templates/template.rscript")))


;;******************Text********************
;; insert real "Tabs"
(define-key text-mode-map (kbd "TAB") 'self-insert-command)

;;********************R*********************
;;ESS config
(add-to-list 'load-path "/home/lich/.emacs.d/mypackages/ESS/lisp/")
(load "ess-site")
(setq-default inferior-R-program-name "R-3.1.2")
;; (require 'ess-site)
;; (require 'ess-eldoc)
(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session
(add-to-list 'auto-mode-alist '("\.rscript$" . R-mode))

;;*******************Perl*******************
;;cperl
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
;;Syntax Highlighting
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1) ; GNU Emacs
  (setq font-lock-auto-fontify t)) ; XEmacs
(setq cperl-invalid-face nil) ;turn off "_"
(setq cperl-electric-keywords t) ;; expands for keywords such as
                                     ;; foreach, while, etc...
;;flymake
(require 'flymake)
;;(global-set-key [f3] 'flymake-mode)
(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
(global-set-key [f4] 'flymake-goto-next-error)
(add-hook 'cperl-mode-hook 'flymake-find-file-hook) ;;auto-start
;;perl auto-complete
(add-hook 'cperl-mode-hook
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)))
(add-hook  'cperl-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
               (auto-complete-mode t)
               (make-variable-buffer-local 'ac-sources)
               (setq ac-sources
                     '(ac-source-perl-completion)))))

;;*********************Python*******************
;; ;; python-mode
;; (setq py-install-directory "~/.emacs.d/mypackages/python-mode")
;; (add-to-list 'load-path py-install-directory)
;; (require 'python-mode)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python2.7" . python-mode))
;; (when (executable-find "ipython")
;;     (setq org-babel-python-mode 'python-mode))
;; ; use IPython
;; (setq-default py-shell-name "ipython")
;; (setq-default py-which-bufname "IPython")
;; ; use the wx backend, for both mayavi and matplotlib
;; (setq py-python-command-args
;;   '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
;;  (setq py-force-py-shell-name-p t)
;; ; switch to the interpreter after executing code
;; (setq py-shell-switch-buffers-on-execute-p t)
;; (setq py-switch-buffers-on-execute-p nil)
;; ; don't split windows
;; (setq py-split-windows-on-execute-p t)
;; ; try to automagically figure out indentation
;; (setq py-smart-indentation t)

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")





;;*****************Clojure and Lisp**************
;;clojure and nrepl mode
(setq auto-mode-alist (cons '("\\.clj$" . clojure-mode) auto-mode-alist))

;; show parens
(show-paren-mode t)

;; (defun turn-on-paren-mode ()
;; "turn on paren-mode without any paremeters, can be used as a hook"
;;  (show-paren-mode t) 
;; )
;;(add-hook 'lisp-mode-hook 'turn-on-paren-mode)
 
;;paredit
   (autoload 'enable-paredit-mode "paredit"
     "Turn on pseudo-structural editing of Lisp code."
     t)
    (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
    (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
    (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
    (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
    (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
    (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
    (add-hook 'clojure-test-mode-hook          #'enable-paredit-mode)
    (add-hook 'nrepl-mode-hook           #'enable-paredit-mode)

;;****************Shell**************
;;essh                                                                   
(require 'essh)                                                    
(defun essh-sh-hook ()                                             
  (define-key sh-mode-map "\C-c\C-r" 'pipe-region-to-shell)        
  (define-key sh-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)        
  (define-key sh-mode-map "\C-c\C-j" 'pipe-line-to-shell)          
  (define-key sh-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step) 
  (define-key sh-mode-map "\C-c\C-f" 'pipe-function-to-shell)      
  (define-key sh-mode-map "\C-c\C-d" 'shell-cd-current-directory)) 
(add-hook 'sh-mode-hook 'essh-sh-hook)                             
;; auto complete path replaced by master setup
;; (defun my-ac-sh-mode ()
;;   (setq ac-sources '(ac-source-filename
;; 		     ac-source-functions
;; 		     ac-source-yasnippet
;; 		     ac-source-variables
;; 		     ac-source-symbols
;; 		     ac-source-features
;; 		     ac-source-abbrev
;; 		     ac-source-words-in-same-mode-buffers
;; 		     ac-source-dictionary
;; 		     ac-source-files-in-current-dir
;; 		     ac-source-filename)))
;; (add-hook 'sh-mode-hook 'my-ac-sh-mode)

;;yasnippet conflict tab
;; (defun yas/org-very-safe-expand ()
;;   (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             ;; yasnippet (using the new org-cycle hooks)
;;             (setq yas/trigger-key [tab])
;;             (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
;;             (define-key yas/keymap [tab] 'yas/next-field)))

;;****************HTML**************
;; (load "nxhtml/autostart.el")

;;*************groovy*****************
;;; turn on syntax hilighting
(global-font-lock-mode 1)
;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.bpipe$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;############################Org mode##############################
 (global-set-key "\C-cl" 'org-store-link)
 (global-set-key "\C-ca" 'org-agenda)
 (global-set-key "\C-cb" 'org-iswitchb)
 (setq org-log-done 'time)

;; Spelling check with flyspell
(require 'flyspell)
(add-hook 'org-mode-hook (lambda () (flyspell-mode 1)))
(add-hook 'org-mode-hook (lambda () (setq ispell-parser 'tex)))

 ;; ;;syntax highlighting within Org 
 ;; (setq org-src-fontify-natively t)
 ;; (require 'org-latex)
 ;; (require 'org-special-blocks) ;; #+begin_foo #+end_foo

;;babel to evaluate the code
 (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (R . t)
     (dot . t)
     (ruby . t)
     (python . t) 
     (sh . t)
     (perl . t)
     (latex . t)
     (clojure . t)
     (sh . t)
     )
 )

;;do not ask before evaluation
(setq org-confirm-babel-evaluate nil)

