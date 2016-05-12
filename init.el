;; -*- coding: utf-8 -*-

;; (require 'cl)

;; With window-system (1/2)
;; Continue to the place just before custom-set-variables
(unless (eq (window-system) nil)
  (setq default-directory "~/")
  (setq command-line-default-directory "~/")
  (tool-bar-mode 0)
  
  (set-frame-parameter nil 'alpha 95) ;; Opacity
  (defun set-alpha (alpha-num)
    "set frame parameter 'alpha"
    (interactive "nAlpha: ")
    (set-frame-parameter nil 'alpha (cons alpha-num '(95)))))

(when (eq window-system 'mac)
  (setq mac-option-modifier 'meta)
  (set-face-attribute 'default nil :family "Monaco" :height 120))

(when (eq window-system 'w32)
  (set-face-attribute 'default nil :family "Consolas" :height 104))

;; Language
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-dos)
(set-default-coding-systems 'utf-8-dos)
(setq default-buffer-file-coding-system 'utf-8-dos)
(setq default-file-name-coding-system 'japanese-cp932-dos)

;; Appearance
(load-theme 'tango-dark)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; Column
(set-fill-column 80)
(column-number-mode 1)

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/auto-install/")

(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match-face nil
                    :background "dark slate blue")
(set-face-attribute 'show-paren-mismatch-face nil
                    :foreground "white" :background "medium violet red")

;;;
;;;
;;; CONFIGURE PACKAGE MANAGERS
;;;
;;;

(setq auto-install-directory "~/.emacs.d/auto-install/")
(require 'auto-install)
(ignore-errors (auto-install-update-emacswiki-package-name t) t)
(auto-install-compatibility-setup)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;;
;;;
;;;
;;;
;;;

(autoload 'php-mode "php-mode-improved" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(semantic-mode 1)
(add-hook 'python-mode-hook (lambda () (setq imenu-create-index-function 'python-imenu-create-index)))
(add-hook 'python-mode-hook (lambda () (electric-indent-mode nil)))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

(require 'anything-startup)
(setq anything-samewindow nil)
(global-set-key "\M-x" 'anything-M-x)
(global-set-key "\C-xb" 'anything-buffers-list)
(global-set-key "\M-." 'anything-imenu)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/ac-dict")
(ac-config-default)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(require 'linum)
(setq linum-format
      (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
(global-linum-mode t)

;; C coding style
(add-hook 'c-mode-hook '(lambda () (hs-minor-mode 1)))
;; Scheme coding style
(add-hook 'scheme-mode-hook '(lambda () (hs-minor-mode 1)))
;; Elisp coding style
(add-hook 'emacs-lisp-mode-hook '(lambda () (hs-minor-mode 1)))
;; Lisp coding style
(add-hook 'lisp-mode-hook '(lambda () (hs-minor-mode 1)))
;; Python coding style
(add-hook 'python-mode-hook '(lambda () (hs-minor-mode 1)))
;; C++ coding style
(add-hook 'c++-mode-hook '(lambda () (hs-minor-mode 1)))

(define-key global-map (kbd "C-\\") 'hs-toggle-hiding)

(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
    (lambda ()
      (flymake-mode t)
      (flymake-jshint-load)
      ))

(defun ac-js2-setup-auto-complete-mode-patch ()
  ;; Patch for ac-js2 to make it work property.
  ;; https://github.com/ScottyB/ac-js2/issues/18

  "Setup ac-js2 to be used with auto-complete-mode."
  (add-to-list 'ac-sources 'ac-source-js2)
  (auto-complete-mode)
  (eval '(ac-define-source "js2"
           '((candidates . ac-js2-ac-candidates)
             (document . ac-js2-ac-document)
             (prefix .  ac-js2-ac-prefix)
             (requires . -1)))))

;; Activate the patch
(advice-add 'ac-js2-setup-auto-complete-mode :override 'ac-js2-setup-auto-complete-mode-patch)

(add-hook 'js2-mode-hook
    (lambda ()
      (flymake-mode t)
      (flymake-jshint-load)
      (ac-js2-mode t)
      ))

;; setting for flymake
(require 'flymake)

(global-set-key (kbd "M-e") 'flymake-goto-next-error)
(global-set-key (kbd "M-E") 'flymake-goto-prev-error)

(setq flymake-start-syntax-check-on-find-file t)
(setq flymake-start-syntax-check-on-newline t)
(setq flymake-no-changes-timeout 0.3)

(autoload 'nodejs-repl "nodejs-repl" "Run Node.js REPL" t)
(setq nodejs-repl-prompt "node> ")

(setq windmove-wrap-around t)
(windmove-default-keybindings)

; (require 'powerline)
; (powerline-default-theme)
(setq imenu-auto-rescan t)

(require 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)

(require 'popwin)
(setq popwin:close-popup-window-timer-interval 0.05)
(setq display-buffer-function 'popwin:display-buffer)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(push '("*ginger*" :height 20 :noselect t) popwin:special-display-config)
(push '("*anything*" :height 20) popwin:special-display-config)
; (push '("^\*magit" :regexp t :position left :width 100) popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

(global-set-key "\C-xf" 'anything-filelist+)

;; anything-git-project
(defun chomp (str)
  (replace-regexp-in-string "[\n\r]+$" "" str))

(defun anything-git-project-project-dir ()
  (chomp
   (shell-command-to-string "git rev-parse --show-toplevel")))

(defun anything-c-sources-git-project-for ()
  (loop for elt in
        '(("Modified files (%s)" . "--modified")
          ("Untracked files (%s)" . "--others --exclude-standard")
          ("All controlled files in this project (%s)" . ""))
        collect
        `((name . ,(format (car elt) (anything-git-project-project-dir)))
          (init . (lambda ()
                    (unless (and ,(string= (cdr elt) "") ;update candidate buffer every time except for that of all project files
                                 (anything-candidate-buffer))
                      (with-current-buffer
                          (anything-candidate-buffer 'global)
                        (insert
                         (shell-command-to-string
                          ,(format "git ls-files --full-name $(git rev-parse --show-cdup) %s"
                                   (cdr elt))))))))
          (candidates-in-buffer)
          (display-to-real . (lambda (name)
                               (format "%s/%s"
                                       (anything-git-project-project-dir) name)))
          (type . file))))

 (defun anything-git-project ()
  (interactive)
  (let* ((sources (anything-c-sources-git-project-for)))
    (anything-other-buffer sources
                           (format "*Anything git project in %s*"
                                   (anything-git-project-project-dir)))))

(global-set-key "\C-x\C-g" 'anything-git-project)

(require 'virtualenvwrapper)
(setq venv-location (expand-file-name "~/.virtualenvs"))
(setq python-environment-directory venv-location)

(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

(defalias 'javascript-mode 'js2-mode)
; (require 'nxhtml)
(require 'markdown-mode)
; (require 'magit)
; (require 'org)
; (require 'org-compat)
; (require 'org-export-generic)

; (require 'gist)

; (require 'longlines-jp)
; (setq longlines-jp-show-hard-newlines t)
; (add-hook 'org-mode-hook 'longlines-jp-mode)
(when (and (equal emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; マウスホイールでスクロール
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
   "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)

;; TeX
(load-library "tex-site.el")
(load-library "auctex/preview.el")
(setq TeX-default-mode 'japanese-latex-mode)
 
(setq japanese-LaTeX-default-style "jarticle")
(setq TeX-output-view-style '(("^dvi$" "." "xdvi '%d'")))
; (setq preview-image-type 'dvipng)
(add-hook 'LaTeX-mode-hook (function (lambda ()
  
)))
 
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
 
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
 
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
 
;; Change key bindings
(add-hook 'reftex-mode-hook
 '(lambda ()
               (define-key reftex-mode-map (kbd "\C-cr") 'reftex-reference)
               (define-key reftex-mode-map (kbd "\C-cl") 'reftex-label)
               (define-key reftex-mode-map (kbd "\C-cc") 'reftex-citation)
))
 
;; 数式のラベル作成時にも自分でラベルを入力できるようにする
(setq reftex-insert-label-flags '("s" "sfte"))
 
;; \eqrefを使う
(setq reftex-label-alist
      '(
        (nil ?e nil "\\eqref{%s}" nil nil)
        ))

(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

(require 'expand-region)
(global-set-key (kbd "C-.") 'er/expand-region)
(global-set-key (kbd "C-,") 'er/contract-region)

(require 'highlight-symbol)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'ido)
(ido-mode t)

(require 'git-timemachine)

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" "~/.emacs.d/el-get/yasnippet/snippets")) ;; 作成するスニペットはここに入る
(yas-global-mode 1)
(add-to-list 'ac-sources '(ac-source-yasnippet))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

                                        ; (require 'point-undo)
                                        ; (define-key global-map [f5] 'point-undo)
                                        ; (define-key global-map [f6] 'point-redo)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-code-indent-offset 2)

(require 'scss-mode)

(require 'tabbar)
(tabbar-mode 1)
;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)
;; グループ化しない
(setq tabbar-buffer-groups-function nil)
;; 画像を使わないことで軽量化する
(setq tabbar-use-images nil)
;; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; 表示するバッファ
(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; キーに割り当てる
(global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
(global-set-key (kbd "M-C-f") 'tabbar-forward-tab)
(global-set-key (kbd "M-<left>") 'tabbar-backward-tab)
(global-set-key (kbd "M-C-b") 'tabbar-backward-tab)

(require 'descbinds-anything)
(descbinds-anything-install)

;; Recentf auto save
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))

(load-library "ginger-api")
(load-library "ginger-rephrase-api")

(defadvice yank (around html-yank-indent)
  "Indents after yanking."
  (let ((point-before (point)))
    ad-do-it
    (when (derived-mode-p 'prog-mode) ;; check what mode we're in
      (indent-region point-before (point)))))
(ad-activate 'yank)

(add-hook 'markdown-mode-hook
          '(lambda ()
             (electric-indent-local-mode -1)
             ))

(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)    
    (beginning-of-line)))
(global-set-key "\C-a" 'my-move-beginning-of-line)

(defun my-end-of-line ()
  (interactive)
  (end-of-line)
  (if (eq last-command this-command)
      (delete-horizontal-space)))
(global-set-key "\C-e" 'my-end-of-line)

;; shell-pop
;; C-tでshellをポップアップ
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term") ;; ansi-termを使うよ
(shell-pop-set-internal-mode-shell "bash") ;; zshを使うよ
(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          '(lambda ()
             (define-key term-raw-map "\C-t" 'shell-pop)))
(defadvice ansi-term (after ansi-term-after-advice (org))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
(global-set-key "\C-t" 'shell-pop)

(global-set-key "\C-h" 'delete-backward-char)

;;; window-resizer
;;; from http://d.hatena.ne.jp/mooz/20100119/p1
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

(global-set-key "\C-c\C-r" 'window-resizer)

;; With window-system (2/2)
(unless (eq (window-system) nil)
  (require 'git-gutter-fringe+)
  (add-hook 'prog-mode-hook 'git-gutter+-mode))

;;
;;
;; BELOW RESERVE FOR THE CUSTOM
;;
;;

(setq custom-file "~/.emacs.d/.custom.el")
(load custom-file)
