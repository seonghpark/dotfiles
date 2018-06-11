(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(setq package-archive-priorities '(("melpa-stable" . 1)))

(defun package--save-selected-packages (&optional value)
  "Set `package--save-selected-packages` to VALUE, but do not save it."
  (when value
    (setq package-selcted-packages value)))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install `use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(use-package evil
  :ensure t
  :init (evil-mode)
  :config
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "M-,") nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-scroll t))


(use-package markdown-mode)

(use-package magit
  :ensure t
  :config
  (use-package evil-magit
    :ensure t))

(use-package ivy
  :config
  (ivy-mode t))

(use-package flycheck)

(use-package company
  :defer 10
  :diminish company-mode
  :bind (:map company-active-map
              ("M-j" . company-select-next)
              ("M-k" . company-select-previous))
  :init (global-company-mode)
  :config
  (setq
   company-idle-delay 0
   company-minimum-prefix-length 2
   company-tooltip-limit 20)
  (setq company-backends (delete 'company-semantic company-backends)))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-file-event-delay           5000
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-no-png-images              nil
          treemacs-project-follow-cleanup     nil
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package ensime
  :ensure t
  :pin melpa)

(use-package company-tern
  :config
  (define-key tern-mode-keymap (kbd "M-.") nil)
  (define-key tern-mode-keymap (kbd "M-,") nil))
(use-package js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js-indent-level 2)
  :config
  (add-hook 'js2-mode-hook
            (lambda ()
              (add-to-list 'company-backends 'company-tern)
              (set 'js2-strict-missing-semi-warning nil)
              (tern-mode)
              (company-mode))))
(use-package xref-js2
  :init
  (define-key js-mode-map (kbd "M-.") nil)
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions
                                       #'xref-js2-xref-backend nil t))))

(use-package elpy
  :init
  (elpy-enable)
  (setq elpy-rpc-backend "jedi"))

(use-package meghanada
  :config
  (add-hook 'java-mode-hook
            (lambda ()
              (meghanada-mode t)
              (flycheck-mode +1)
              (setq c-basic-offset 2)
              (setq indent-tabs-mode nil)))
  (setq meghanada-java-path "java")
  (setq meghanada-maven-path "mvn"))

(use-package groovy-mode)

(use-package rtags
  :ensure t
  :config
  (use-package flycheck-rtags))

(use-package irony
  :ensure t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (setq company-clang-executable "/usr/bin/clang")
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  :config
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (use-package company-irony
    :ensure t
    :config
    (add-to-list 'company-backends 'company-irony))
  (use-package company-irony-c-headers
    :ensure t
    :config
    (add-to-list 'company-backends 'company-irony-c-headers)))

(use-package zenburn-theme)
