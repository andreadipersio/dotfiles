(package-initialize)

(load "~/.emacs.d/my.el")

;;
;; General purpose packages
;;
(load "~/.emacs.d/my-packages.el")

;;
;; Language specific packages
;;
(load "~/.emacs.d/my-rust-packages.el")
(load "~/.emacs.d/my-ruby-packages.el")
(load "~/.emacs.d/my-php-packages.el")

;;
;; Site specific packages
;;
(load "~/.emacs.d/my-local-packages.el")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
