;; -*- coding: utf-8 -*-

;; (require 'cl)
;; Language
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-dos)
(set-default-coding-systems 'utf-8-dos)
(setq default-buffer-file-coding-system 'utf-8-dos)
(setq default-file-name-coding-system 'japanese-cp932-dos)

;; Appearance
(load-theme 'tango-dark)
(set-face-attribute 'default nil :family "Consolas" :height 104)

;; Column
(set-fill-column 80)
(column-number-mode 1)

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/magit")
(add-to-list 'load-path "~/.emacs.d/auto-install/")

(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match-face nil
                    :background "dark slate blue")
(set-face-attribute 'show-paren-mismatch-face nil
                    :foreground "white" :background "medium violet red")

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加

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
; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
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

; (add-to-list 'load-path "/home/mecab/.emacs.d/el-get/jshint-mode")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
    (lambda ()
      (flymake-mode t)
      (flymake-jshint-load)
      ))
(add-hook 'js2-mode-hook
    (lambda ()
      (flymake-mode t)
      (flymake-jshint-load)
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
(push '("^\*magit" :regexp t :position left :width 100) popwin:special-display-config)
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

; (require 'virtualenv)

(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

(defalias 'javascript-mode 'js2-mode)
; (require 'nxhtml)
; (require 'markdown-mode)
(require 'magit)
; (require 'org)
; (require 'org-compat)
; (require 'org-export-generic)
; (load-library "markdown")

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

(require 'git-gutter-fringe+)
(add-hook 'prog-mode-hook 'git-gutter+-mode)

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
(autoload 'powershell-mode "PowerShell-Mode" "Run powershell as a shell within emacs." t)
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term") ;; ansi-termを使うよ
(shell-pop-set-internal-mode-shell "powershell") ;; zshを使うよ
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "platex")
 '(LaTeX-command-style (quote (("" "%(PDF)%(latex) %s"))))
 '(TeX-command-list (quote (("pdf" "dvipdfmx -V 4 '%s' " TeX-run-command t nil) ("acroread" "start \"\" %(pf)" TeX-run-command t nil) ("pLaTeX" "%(PDF)platex %s" TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX") ("upLaTeX" "%(PDF)uplatex %s" TeX-run-TeX nil (latex-mode) :help "Run Unicode pLaTeX") ("pTeX" "%(PDF)ptex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode) :help "Run ASCII pTeX") ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "pbibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "%(makeindex) %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-expand-list (quote (("%p" TeX-printer-query) ("%q" (lambda nil (TeX-printer-query t))) ("%V" (lambda nil (TeX-source-correlate-start-server-maybe) (TeX-view-command-raw))) ("%vv" (lambda nil (TeX-source-correlate-start-server-maybe) (TeX-output-style-check TeX-output-view-style))) ("%v" (lambda nil (TeX-source-correlate-start-server-maybe) (TeX-style-check TeX-view-style))) ("%r" (lambda nil (TeX-style-check TeX-print-style))) ("%l" (lambda nil (TeX-style-check LaTeX-command-style))) ("%(PDF)" (lambda nil (if (and (eq TeX-engine (quote default)) (or TeX-PDF-mode TeX-DVI-via-PDFTeX)) "pdf" ""))) ("%(PDFout)" (lambda nil (cond ((and (eq TeX-engine (quote xetex)) (not TeX-PDF-mode)) " -no-pdf") ((and (eq TeX-engine (quote luatex)) (not TeX-PDF-mode)) " --output-format=dvi") ((and (eq TeX-engine (quote default)) (not TeX-PDF-mode) TeX-DVI-via-PDFTeX) " \"\\pdfoutput=0 \"") (t "")))) ("%(mode)" (lambda nil (if TeX-interactive-mode "" " -interaction=nonstopmode"))) ("%(o?)" (lambda nil (if (eq TeX-engine (quote omega)) "o" ""))) ("%(tex)" (lambda nil (eval (nth 2 (assq TeX-engine (TeX-engine-alist)))))) ("%(latex)" (lambda nil (eval (nth 3 (assq TeX-engine (TeX-engine-alist)))))) ("%(execopts)" ConTeXt-expand-options) ("%S" TeX-source-correlate-expand-options) ("%dS" TeX-source-specials-view-expand-options) ("%cS" TeX-source-specials-view-expand-client) ("%(outpage)" (lambda nil (or (when TeX-source-correlate-output-page-function (funcall TeX-source-correlate-output-page-function)) "1"))) ("%s" file nil t) ("%t" file t t) ("%`" (lambda nil (setq TeX-command-pos t TeX-command-text ""))) (" \"\\" (lambda nil (if (eq TeX-command-pos t) (setq TeX-command-pos pos pos (+ 3 pos)) (setq pos (1+ pos))))) ("\"" (lambda nil (if (numberp TeX-command-pos) (setq TeX-command-text (concat TeX-command-text (substring command TeX-command-pos (1+ pos))) command (concat (substring command 0 TeX-command-pos) (substring command (1+ pos))) pos TeX-command-pos TeX-command-pos t) (setq pos (1+ pos))))) ("%'" (lambda nil (prog1 (if (stringp TeX-command-text) (progn (setq pos (+ (length TeX-command-text) 9) TeX-command-pos (and (string-match " " (funcall file t t)) "\"")) (concat TeX-command-text " \"\\input\"")) (setq TeX-command-pos nil) "") (setq TeX-command-text nil)))) ("%n" TeX-current-line) ("%d" file "dvi" t) ("%f" file "ps" t) ("%o" (lambda nil (funcall file (TeX-output-extension) t))) ("%b" TeX-current-file-name-master-relative) ("%m" preview-create-subdirectory) ("%(pf)" file "pdf" nil))))
 '(ac-auto-show-menu 0.1)
 '(ac-delay 0.05)
 '(ac-use-menu-map t)
 '(anything-c-use-adaptative-sorting t)
 '(anything-idle-delay 0.01 t)
 '(anything-input-idle-delay 0.1 t)
 '(electric-indent-mode t)
 '(electric-layout-mode nil)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.3)
 '(highlight-symbol-idle-delay 0.5)
 '(highlight-symbol-on-navigation-p t)
 '(indent-tabs-mode nil)
 '(js2-auto-indent-p t)
 '(js2-enter-indents-newline t)
 '(js2-global-externs (quote ("$" (\, "ko") (\, "Enumerable") (\, "localStorage"))))
 '(js2-idle-timer-delay 0.1)
 '(js2-include-node-externs t)
 '(js2-indent-on-enter-key t)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(preview-dvipng-command "mudraw -o \"%m/prev%%03d.png\" %(pf)")
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(yas-trigger-key "TAB"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-function-param ((t (:foreground "Green"))))
 '(magit-item-highlight ((t (:inherit highlight :background "PeachPuff4" :foreground "snow"))))
 '(powerline-active1 ((t (:background "cyan" :foreground "brightwhite"))) t)
 '(powerline-active2 ((t (:inherit mode-line :background "brightwhite"))) t))
