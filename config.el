;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(require 'privateinfo.config "~/.doom.d/privateinfo.config.el")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hack" :size 12))
(setq doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-opera)
;; (setq doom-theme 'doom-dark+)
(setq doom-theme 'doom-dracula)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;;; from https://dotdoom.rgoswami.me/config.html

;;; helm
;; Undo the helm text enlargement in childframes
(setq +helm-posframe-text-scale 0)

;; More sane helm
(after! helm
  ;; I want backspace to go up a level, like ivy
  (add-hook! 'helm-find-files-after-init-hook
    (map! :map helm-find-files-map
          "<DEL>" #'helm-find-files-up-one-level)))
;; /helm

;;; company
;; C-/ to auto-complete
(with-eval-after-load "company"
  (global-unset-key (kbd "C-/"))
  (global-set-key (kbd "C-/") 'company-complete))
(eval-after-load "undo-tree"  ;; after! doesn't work for some reason.
  (define-key undo-tree-map (kbd "C-/") nil))
;; Make company ignore case when completing
(after! 'company
  (setq completion-ignore-case t))
;; /compnay

;; replace stuff
(map! :leader
 (:prefix ("r" . "Replace")
  :desc "String" "s" 'replace-string
  :desc "Query" "q" 'query-replace
  (:prefix ("r" . "Regexp")
   :desc "String" "s" 'replace-regexp
   :desc "Query" "q" 'query-replace-regexp)))

;; Better keybinding for ace-window
(map! :leader
      :nv "w a" nil
      :desc "Select window using ace-window"
      :n "w a" #'+treemacs/toggle)

;; Remap treemacs toggle
(map! :leader
      :nv "o n" nil
      :desc "Open treemacs pane"
      :n "o n" #'+treemacs/toggle)
;; Remap teemacs finding stuff
(map! :leader
      :nv "o N" nil
      :desc "Treemacs find file"
      :n "o N" 'treemacs-find-file)

;;;;; I may repent some day.
;;;; Actually, evil is better.
;;; God-mode configs
;; (after! 'god-mode
;; 	(progn
;;     (global-set-key (kbd "M-SPC") #'god-mode-all)
;;     (define-key god-local-mode-map (kbd ".") #'repeat)
;;     (define-key god-local-mode-map (kbd "i") #'god-mode-all)
;;     (setq god-exempt-major-modes nil)
;;     (setq god-exempt-predicates nil)
;;     (defun my-god-mode-update-cursor ()
;;       (setq cursor-type (if (or god-local-mode buffer-read-only)
;;                             'box
;;                           'bar)))
;;     (add-hook 'god-mode-enabled-hook #'my-god-mode-update-cursor)
;;     (add-hook 'god-mode-disabled-hook #'my-god-mode-update-cursor)
;;     (define-key isearch-mode-map (kbd "<escape>") #'god-mode-isearch-activate)
;;     (define-key god-mode-isearch-map (kbd "<escape>") #'god-mode-isearch-disable)
;;     (add-to-list 'god-exempt-major-modes 'dired-mode)))


;; :ui doom-dashboard
(setq fancy-splash-image (concat doom-private-dir "splash.png"))
