(add-to-list 'load-path "~/.emacs.d/mypackages/")

(setq user-mail-address "lch14forever@gmail.com")
(setq user-full-name "Li Chenhao")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (deeper-blue))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;package repo
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

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

;;ESS config
 (setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
 (setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session
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
(global-set-key [f3] 'flymake-mode)
(global-set-key [f4] 'flymake-display-err-menu-for-current-line)
(global-set-key [f5] 'flymake-goto-next-error)
;;(add-hook 'find-file-hook 'flymake-find-file-hook) ;;auto-start


;;clojure and nrepl mode
(setq auto-mode-alist (cons '("\\.clj$" . clojure-mode) auto-mode-alist))
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

;;ibus
(require 'ibus)
  (global-set-key "\C-ci" 'ibus-mode)

;;Org mode
 (global-set-key "\C-cl" 'org-store-link)
 (global-set-key "\C-ca" 'org-agenda)
 (global-set-key "\C-cb" 'org-iswitchb)
 (setq org-log-done 'time)

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
     )
 )

;;do not ask before evaluation
(setq org-confirm-babel-evaluate nil)

;;to use minted package
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(("linenos" "true") 
        ("bgcolor" "bg")  ;; this is dependent on the color being defined
        ("stepnumber" "1")
        ("numbersep" "10pt")
        )
      )
(setq my-org-minted-config (concat "%% minted package configuration settings\n"
                                   "\\usepackage{minted}\n"
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
                      " -shell-escape -interaction nonstopmode'  -pdf -f  %f" ))))
(add-hook 'org-export-before-parsing-hook 'set-org-latex-pdf-process)

;; (setq org-latex-pdf-process '("xelatex  -interaction nonstopmode -output-directory %o %f"
;; 			      "xelatex  -interaction nonstopmode -output-directory %o %f"
;; 			      "xelatex  -interaction nonstopmode -output-directory %o %f"))


(defun my-auto-tex-packages (backend)
  "Automatically set packages to include for different LaTeX engines"
  (let ((my-org-export-latex-packages-alist 
         `(("pdflatex" . (("AUTO" "inputenc" t)
                          ("T1" "fontenc" t)
                          ("" "textcomp" t)
                          ("" "varioref"  nil)
                          ("capitalize,noabbrev" "cleveref"  nil)
                          ,my-org-minted-config))
           ("xelatex" . (("" "url" t)
                         ("" "fontspec" t)
                         ("" "xltxtra" t)
                         ("" "xunicode" t)
                          ("" "varioref"  nil)
                          ("capitalize,noabbrev" "cleveref"  nil)
                         ,my-org-minted-config ))
           ("lualatex" . (("" "url" t)
                       ("" "fontspec" t)
                          ("" "varioref"  nil)
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
