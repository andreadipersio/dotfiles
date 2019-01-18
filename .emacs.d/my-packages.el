 (require 'package)

;;
;; Package Archives
;;
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)

;;
;; Required Packages
;;

(defvar required-packages
  '(
    ;; foundamentals
    let-alist
    magit
    cider

    ;; Completion
    ivy
    counsel
    swiper
    flx
    company    

    ;; project navigation
    projectile
    rg
    ripgrep

    ;; syntax checking
    flycheck    

    ;; various modes
    yaml-mode
    markdown-mode

    ) "a list of packages to ensure are installed at launch.")

(require 'cl)

;; Ensure required packages are installed

(defun packages-installed-p (packages)
  (loop for p in packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(defun install-missing-packages (packages)
  (unless (packages-installed-p packages)
    (message "%s" "runnning package-refresh-contents...")
    (package-refresh-contents)
    (message "%s" " done")
    (dolist (p packages)
      (when (not (package-installed-p p))
	(package-install p)))))

(install-missing-packages required-packages)

;;
;; Packages Configuration
;;

(require 'magit)
(require 'cider)
(require 'company)

;;
;; ivy
;;

(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-initial-input-alist nil)

;; Enable fuzzy matching
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key "\C-s" 'swiper)

;;
;; Projectile
;;

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)

;;
;; Company
;;

;;; Prevent suggestions from being triggered automatically. In particular,
;;; this makes it so that:
;;; - TAB will always complete the current selection.
;;; - RET will only complete the current selection if the user has explicitly
;;;   interacted with Company.
;;; - SPC will never complete the current selection.
;;;
;;; Based on:
;;; - https://github.com/company-mode/company-mode/issues/530#issuecomment-226566961
;;; - https://emacs.stackexchange.com/a/13290/12534
;;; - http://stackoverflow.com/a/22863701/3538165
;;;
;;; See also:
;;; - https://emacs.stackexchange.com/a/24800/12534
;;; - https://emacs.stackexchange.com/q/27459/12534

;; <return> is for windowed Emacs; RET is for terminal Emacs
(dolist (key '("<return>" "RET"))
  ;; Here we are using an advanced feature of define-key that lets
  ;; us pass an "extended menu item" instead of an interactive
  ;; function. Doing this allows RET to regain its usual
  ;; functionality when the user has not explicitly interacted with
  ;; Company.
  (define-key company-active-map (kbd key) 
   `(menu-item nil company-complete
                :filter ,(lambda (cmd)
                           (when (company-explicit-action-p)
                             cmd)))))

(define-key company-active-map (kbd "TAB") #'company-complete-selection)
(define-key company-active-map (kbd "SPC") nil)

;; Company appears to override the above keymap based on company-auto-complete-chars.
;; Turning it off ensures we have full control.
(setq company-auto-complete-chars nil)
