(require 'package)
(add-to-list 'package-archives' ("melpa" . "http://melpa.org/packages/"))
(custom-set-variables
 '(custom-enabled-themes (quote (tango-dark)))
 '(ecb-options-version "2.40")
 '(global-ede-mode t)
 '(package-selected-packages (quote (auto-complete))))
(custom-set-faces
 )
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
	kept-new-versions 2
	kept-old-versions 2
	version-control t)
(global-linum-mode t)
