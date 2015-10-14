;;###############################General settings######################################
(add-to-list 'load-path "~/.emacs.d/mypackages/")
(setq user-mail-address "lichenhao.sg@gmail.com"
      user-full-name "Li Chenhao")
;;package repo
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (package-initialize)

;;#######################################Mini buffer###################################
(ido-mode t)


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


;;******************Text********************
;; insert real "Tabs"
(define-key text-mode-map (kbd "TAB") 'self-insert-command)

;;********************R*********************
;;ESS config
(add-to-list 'load-path "/home/lich/.emacs.d/mypackages/ESS/lisp/")
(load "ess-site")
;; (require 'ess-site)
;; (require 'ess-eldoc)
(setq-default inferior-R-program-name "R-3.1.2")
(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session
