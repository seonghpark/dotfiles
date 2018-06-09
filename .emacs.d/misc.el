(setq
  inhibit-startup-screen t
  create-lockfiles nil
  make-backup-files nil
  colomn-number-mode t
  scroll-error-top-bottom t
  show-paren-delay 0.5
  sentence-end-double-space nil)

(setq-default
  indent-tabs-mode nil
  tab-width 4
  c-basic-offset 4)

;; open shell from current buffer
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell*") display-buffer-same-window))
