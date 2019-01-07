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
    let-alist
    magit
    cider
    ivy
    counsel
    swiper
    flx
    projectile
    rg
    ripgrep
    company
    rust-mode
    racer
    flycheck
    flycheck-rust
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
;; Rust
;;
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'flycheck-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
