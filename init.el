;; disable ring bell
 (setq ring-bell-function 'ignore)

;; mouse scroll
(setq mouse-wheel-scroll-amount '(5 ((shift) . 5))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; show column
(setq column-number-mode t)

;; the 80 column rule
(require 'whitespace)
(setq whitespace-style '(lines-tail))
(global-whitespace-mode t)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;; package
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(setq package-enable-at-startup nil)

;; set path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; backup in one place
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; theme
(load-theme 'tsdh-light)

;; pure style
(require 'ps-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; (add-hook 'c-mode-common-hook '(lambda () (add-to-list ‘write-file-functions ‘delete-trailing-whitespace)))


;; company-mode
(add-hook 'after-init-hook 'global-company-mode)

 
;; anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)
(eval-after-load "company"
'(add-to-list 'company-backends 'company-anaconda))


;; helm
(require 'helm)
(require 'helm-config)
(require 'helm-ls-git)


;; helm-descbinds
(require 'helm-descbinds)
(helm-descbinds-mode)


;; helm list buffers
(global-set-key [remap switch-to-buffer] 'helm-buffers-list)


;; helm-ls-git
(setq helm-ls-git-grep-command
      "git grep -n%cH --color=always --full-name -e %p")

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x f") 'helm-browse-project)
(setq helm-grep-default-command "ack -Hn --smart-case --no-group %p %f"
      helm-grep-default-recurse-command "ack -H -C3 --smart-case --no-group %p %f")
(global-set-key (kbd "C-S-s") 'helm-grep-do-git-grep)


;; helm-swoop
(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)


;; helm gtags
(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'python-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-x 4 .") 'helm-gtags-find-tag-other-window)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(setq helm-gtags-auto-update t) ; auto update tags


;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; ace window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; line number
(global-linum-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a3132bd39a977ddde4c002f8bd0ef181414c3fbe9228e3643b999491192680ad" default)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
