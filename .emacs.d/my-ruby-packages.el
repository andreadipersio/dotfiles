(defvar required-ruby-packages
  '(
    enh-ruby-mode
    chruby
    yard-mode
    robe
    inf-ruby
    ))

(install-missing-packages required-ruby-packages)

;;
;; Ruby
;;
(with-eval-after-load 'company
                 '(push 'company-robe company-backends))

(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)

(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'yard-mode)
(add-hook 'ehn-ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'ehn-ruby-mode-hook 'company-mode)

(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(chruby "2.5.3")
