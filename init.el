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

;;ibus
(require 'ibus)
  (global-set-key "\C-ci" 'ibus-mode)
;;******************Text********************
;; insert real "Tabs"
(define-key text-mode-map (kbd "TAB") 'self-insert-command)

;;********************R*********************
;;ESS config
(require 'ess-site)
(require 'ess-eldoc)
(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session
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

;;############################Org mode##############################
 (global-set-key "\C-cl" 'org-store-link)
 (global-set-key "\C-ca" 'org-agenda)
 (global-set-key "\C-cb" 'org-iswitchb)
 (setq org-log-done 'time)

;; Spelling check with flyspell
(require 'flyspell)
(add-hook 'org-mode-hook (lambda () (flyspell-mode 1)))
(add-hook 'org-mode-hook (lambda () (setq ispell-parser 'tex)))

 ;;syntax highlighting within Org 
 (setq org-src-fontify-natively t)
 (require 'org-latex)
 (require 'org-special-blocks) ;; #+begin_foo #+end_foo

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

;;to use minted package
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(("linenos" "true")
	("fontsize" "\\scriptsize")
        ("bgcolor" "bg")  ;; this is dependent on the color being defined
        ("stepnumber" "1")
        ("numbersep" "10pt")
        )
      )
(setq my-org-minted-config (concat "%% minted package configuration settings\n"
                                   "\\usepackage{minted}\n"
				   "\\renewcommand\\listingscaption{Source}"
                                   "\\definecolor{bg}{rgb}{0.8,0.8,0.8}\n" 
                                   "\\usemintedstyle{emacs}\n"
                                   "\\usepackage{upquote}\n"
                                   "\\AtBeginDocument{%\n"
                                   "\\def\\PYZsq{\\textquotesingle}%\n"
                                   "}\n"
                                    ))

;;#+LATEX_CMD: pdflatex/xelatex/lualatex
(defun my-org-tex-cmd ()
  "set the correct type of LaTeX process to run for the org buffer"
  (let ((case-fold-search t))
    (if (string-match  "^#\\+LATEX_CMD:\s+\\(\\w+\\)"   
                       (buffer-substring-no-properties (point-min) (point-max)))
        (downcase (match-string 1 (buffer-substring-no-properties (point-min) (point-max))))
      "xelatex"
    ))
  )

(defun set-org-latex-pdf-process (backend)
  "When exporting from .org with latex, automatically run latex,
   pdflatex, or xelatex as appropriate, using latexmk."
  (setq org-latex-pdf-process
        (list (concat "latexmk -pdflatex='" 
                      (my-org-tex-cmd)
                      " -shell-escape -interaction nonstopmode' -CF  -pdf -f  %f" ))))
(add-hook 'org-export-before-parsing-hook 'set-org-latex-pdf-process)

;; (setq org-latex-pdf-process '("xelatex  -interaction nonstopmode -output-directory %o %f"
;; 			      "xelatex  -interaction nonstopmode -output-directory %o %f"
;; 			      "xelatex  -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-default-packages-alist
        '(("" "fixltx2e" nil)
          ("" "longtable" nil)
          ("" "graphicx" t)
          ("" "wrapfig" nil)
          ("" "soul" t)
          ("" "marvosym" t)
          ("" "wasysym" t)
          ("" "latexsym" t)
          ("" "tabularx" nil)
          ("" "booktabs" nil)
          ("" "xcolor" nil)
          "\\tolerance=1000"
          )
        )


(defun my-auto-tex-packages (backend)
  "Automatically set packages to include for different LaTeX engines"
  (let ((my-org-export-latex-packages-alist 
         `(("pdflatex" . (("AUTO" "inputenc" t)
                          ("T1" "fontenc" t)
                          ("" "textcomp" t)
                          ("" "varioref"  nil)
			  ("" "hyperref" nil) ;; It is better to put hyperref as the last package imported
			  ("" "apacite" t)
			  ("" "natbib" t)			 
                          ("capitalize,noabbrev" "cleveref"  nil)
                          ,my-org-minted-config))
           ("xelatex" . (("" "url" t)
                         ("" "fontspec" t)
                         ("" "xltxtra" t)
                         ("" "xunicode" t)
			 ("" "apacite" t)
			 ("" "natbib" t)
                          ("" "varioref"  nil)
			  ("" "hyperref" nil)
                          ("capitalize,noabbrev" "cleveref"  nil)
                         ,my-org-minted-config ))
           ("lualatex" . (("" "url" t)
                       ("" "fontspec" t)
                          ("" "varioref"  nil)
			  ("" "hyperref" nil)
			  ("" "apacite" t)
			  ("" "natbib" t)
                          ("capitalize,noabbrev" "cleveref"  nil)
                       ,my-org-minted-config ))
           ))
        (which-tex (my-org-tex-cmd)))
    (if (car (assoc which-tex my-org-export-latex-packages-alist))
        (setq org-latex-packages-alist 
              (cdr (assoc which-tex my-org-export-latex-packages-alist)))
      (warn "no packages")
      )
    )
  )
(add-hook 'org-export-before-parsing-hook 'my-auto-tex-packages 'append)

;;LATEX_CLASSES
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(setq org-latex-classes
                `(("book"
                        (,@ (concat  "\\documentclass[]{book}\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     ))
                        ("\\chapter{%s}" . "\\chapter*{%s}")
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

		  ("memoir"
                        (,@ (concat  "\\documentclass[11pt,oneside,a4paper,x11names]{memoir}\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     "\\counterwithout{section}{chapter}\n"
                                     ))
                        ("\\chapter{%s}" . "\\chapter*{%s}")
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                  ("article"
                        (,@ (concat  "\\documentclass[11pt,oneside,a4paper,x11names]{article}\n"
				     "\\usepackage{tabulary}\n"
				     "\\usepackage{amsmath}\n"
				    ;; "\\usepackage{appendix}\n"
				     "\\usepackage[margin=10pt,font=small,labelfont=bf]{caption}\n"
				     "\\usepackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}\n"
				    ;; "\\usepackage{hyperref}\n"
				    ;; "\\usepackage{float}\n"
				    ;; "\\floatstyle{plaintop}\n"
				    ;; "\\restylefloat{table}\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     ))
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
		  ("cn-article"
                        (,@ (concat  "\\documentclass[11pt,oneside,a4paper,x11names]{article}\n"
				     "\\usepackage[BoldFont=楷体,ItalicFont=楷体,BoldItalicFont=楷体,SlantedFont=楷体,BoldSlantedFont=楷体]{xeCJK}\n"
				     "\\setCJKmainfont{楷体}\n"
				     "\\setCJKsansfont{楷体}\n"
				     "%use fc-list :lang=zh-cn to show all the installed Chinese fonts\n"
				     "%楷体，幼圆，仿宋，新宋体，黑体\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     ))
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
("beamer"
	 (,@ (concat "\\documentclass[compress,presentation]{beamer}\n"
		     "\\institute{National University of Singapore}\n"
		     "\\usetheme{Ilmenau}\n"
;;		     "\\usecolortheme{lily}"
		     "\\usefonttheme{structurebold}\n"
		     "\\useoutertheme[subsection=true]{smoothbars}\n"
		     "\\useinnertheme{circles}\n"
		     "\\setbeamercovered{transparent}"
		     ))
	 ("\\section{%s}" . "\\section*{%s}")
	 ("\\subsection{%s}" . "\\subsection*{%s}")
	 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
		   ))


(defun my/org-export-ignoreheadings-hook (backend)
   "My backend aware export preprocess hook."
    (save-excursion
      (let* ((tag "ignoreheading"))
        (org-map-entries (lambda ()
                           (delete-region (point-at-bol) (point-at-eol)))
                         (concat ":" tag ":")))
))
(setq org-export-before-processing-hook 'my/org-export-ignoreheadings-hook)

;;beamer setup
(require 'ox-beamer)
(setq org-beamer-outline-frame-options "")

;;org-reveal
(require 'ox-reveal)
(setq org-reveal-root "file:////home/lichenhao/Documents/reveal.js")

;; Publishing
(require 'ox-publish)
(require 'ox-html)
(setq org-publish-project-alist
      '(
       ;; ... add all the components here (see below)...
	("org-notes"
	 :base-directory "~/web-org/"
	 :base-extension "org"
	 :publishing-directory "~/web-public_html/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4             ; Just the default for this project.
	 :auto-preamble t
	 )
	("org-static"
	 :base-directory "~/web-org/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/web-public_html/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("website" :components ("org-notes" "org-static"))
      ))

;; TODO keyword markup
