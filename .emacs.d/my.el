;; Less noise

(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-screen t)

;;
;; Paths
;;
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.emacs.d/backup"))
 delete-old-versions t
 kept-new-versions 5
 kept-old-versions 2
 version-control t)


;;
;; Aspect
;;
(add-to-list 'load-path "~/.emacs.d/themes")
(require 'material-theme)

(add-to-list 'default-frame-alist
	     '(font . "Fira Code Medium-12"))

(add-to-list 'default-frame-alist	     
	     '(width . 120))

(add-to-list 'default-frame-alist
	     '(height . 60))

(show-paren-mode 1)
