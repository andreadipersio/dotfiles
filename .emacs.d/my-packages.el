(require 'package)

;;
;; Package Archives
;;

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;
;; Required Packages
;;

(defvar required-packages
  '(
    magit
    cider
    ivy
    projectile
    ) "a list of packages to ensure are installed at launch.")

(require 'cl)

;; Ensure required packages are installed

(defun packages-installed-p ()
  (loop for p in required-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (packages-installed-p)
  (message "%s" "runnning package-refresh-contents...")
  (package-refresh-contents)
  (message "%s" " done")
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;
;; Packages Configuration
;;

(require 'magit)
(require 'cider)

(ivy-mode 1)


(dolist (p required-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;
;; Packages Configuration
;;

(require 'magit)
(require 'cider)

(ivy-mode 1)

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
