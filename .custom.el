(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "platex")
 '(LaTeX-command-style (quote (("" "%(PDF)%(latex) %s"))))
 '(TeX-PDF-mode t)
 '(TeX-command-list
   (quote
    (("pdf" "dvipdfmx -V 4 '%s' " TeX-run-command t nil)
     ("acroread" "start \"\" %(pf)" TeX-run-command t nil)
     ("pLaTeX" "%(PDF)platex %s" TeX-run-TeX nil
      (latex-mode)
      :help "Run ASCII pLaTeX")
     ("upLaTeX" "%(PDF)uplatex %s" TeX-run-TeX nil
      (latex-mode)
      :help "Run Unicode pLaTeX")
     ("pTeX" "%(PDF)ptex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode)
      :help "Run ASCII pTeX")
     ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "pbibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
     ("View" "open -a Preview.app %s.pdf" TeX-run-command t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
     ("Index" "%(makeindex) %s" TeX-run-command nil t :help "Create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-expand-list
   (quote
    (("%p" TeX-printer-query)
     ("%q"
      (lambda nil
        (TeX-printer-query t)))
     ("%V"
      (lambda nil
        (TeX-source-correlate-start-server-maybe)
        (TeX-view-command-raw)))
     ("%vv"
      (lambda nil
        (TeX-source-correlate-start-server-maybe)
        (TeX-output-style-check TeX-output-view-style)))
     ("%v"
      (lambda nil
        (TeX-source-correlate-start-server-maybe)
        (TeX-style-check TeX-view-style)))
     ("%r"
      (lambda nil
        (TeX-style-check TeX-print-style)))
     ("%l"
      (lambda nil
        (TeX-style-check LaTeX-command-style)))
     ("%(PDF)"
      (lambda nil
        (if
            (and
             (eq TeX-engine
                 (quote default))
             (or TeX-PDF-mode TeX-DVI-via-PDFTeX))
            "pdf" "")))
     ("%(PDFout)"
      (lambda nil
        (cond
         ((and
           (eq TeX-engine
               (quote xetex))
           (not TeX-PDF-mode))
          " -no-pdf")
         ((and
           (eq TeX-engine
               (quote luatex))
           (not TeX-PDF-mode))
          " --output-format=dvi")
         ((and
           (eq TeX-engine
               (quote default))
           (not TeX-PDF-mode)
           TeX-DVI-via-PDFTeX)
          " \"\\pdfoutput=0 \"")
         (t ""))))
     ("%(mode)"
      (lambda nil
        (if TeX-interactive-mode "" " -interaction=nonstopmode")))
     ("%(o?)"
      (lambda nil
        (if
            (eq TeX-engine
                (quote omega))
            "o" "")))
     ("%(tex)"
      (lambda nil
        (eval
         (nth 2
              (assq TeX-engine
                    (TeX-engine-alist))))))
     ("%(latex)"
      (lambda nil
        (eval
         (nth 3
              (assq TeX-engine
                    (TeX-engine-alist))))))
     ("%(execopts)" ConTeXt-expand-options)
     ("%S" TeX-source-correlate-expand-options)
     ("%dS" TeX-source-specials-view-expand-options)
     ("%cS" TeX-source-specials-view-expand-client)
     ("%(outpage)"
      (lambda nil
        (or
         (when TeX-source-correlate-output-page-function
           (funcall TeX-source-correlate-output-page-function))
         "1")))
     ("%s" file nil t)
     ("%t" file t t)
     ("%`"
      (lambda nil
        (setq TeX-command-pos t TeX-command-text "")))
     (" \"\\"
      (lambda nil
        (if
            (eq TeX-command-pos t)
            (setq TeX-command-pos pos pos
                  (+ 3 pos))
          (setq pos
                (1+ pos)))))
     ("\""
      (lambda nil
        (if
            (numberp TeX-command-pos)
            (setq TeX-command-text
                  (concat TeX-command-text
                          (substring command TeX-command-pos
                                     (1+ pos)))
                  command
                  (concat
                   (substring command 0 TeX-command-pos)
                   (substring command
                              (1+ pos)))
                  pos TeX-command-pos TeX-command-pos t)
          (setq pos
                (1+ pos)))))
     ("%'"
      (lambda nil
        (prog1
            (if
                (stringp TeX-command-text)
                (progn
                  (setq pos
                        (+
                         (length TeX-command-text)
                         9)
                        TeX-command-pos
                        (and
                         (string-match " "
                                       (funcall file t t))
                         "\""))
                  (concat TeX-command-text " \"\\input\""))
              (setq TeX-command-pos nil)
              "")
          (setq TeX-command-text nil))))
     ("%n" TeX-current-line)
     ("%d" file "dvi" t)
     ("%f" file "ps" t)
     ("%o"
      (lambda nil
        (funcall file
                 (TeX-output-extension)
                 t)))
     ("%b" TeX-current-file-name-master-relative)
     ("%m" preview-create-subdirectory)
     ("%(pf)" file "pdf" nil))))
 '(ac-auto-show-menu 0.1)
 '(ac-delay 0.05)
 '(ac-use-menu-map t)
 '(anything-c-use-adaptative-sorting t)
 '(anything-idle-delay 0.01 t)
 '(anything-input-idle-delay 0.1 t)
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(electric-indent-mode t)
 '(electric-layout-mode nil)
 '(flycheck-disabled-checkers (quote (javascript-jshint javascript-jscs)))
 '(frame-background-mode (quote dark))
 '(global-whitespace-mode t)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.3)
 '(highlight-symbol-idle-delay 0.5)
 '(highlight-symbol-on-navigation-p t)
 '(indent-tabs-mode nil)
 '(jedi:get-in-function-call-delay 300)
 '(js2-auto-indent-p t)
 '(js2-enter-indents-newline t)
 '(js2-global-externs
   (quote
    ("$"
     (\, "ko")
     (\, "Enumerable")
     (\, "localStorage"))))
 '(js2-idle-timer-delay 0.1)
 '(js2-include-node-externs t)
 '(js2-indent-on-enter-key t)
 '(org-agenda-files (quote ("~/Documents/junk" "~/Documents/journal")))
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (xah-lookup tabulated-list python-mode magit git-gutter-fringe+ emmet-mode)))
 '(preview-dvipng-command "mudraw -o \"%m/prev%%03d.png\" %(pf)")
 '(shell-pop-shell-type
   (quote
    ("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell)))))
 '(shell-pop-universal-key "C-t")
 '(tabbar-background-color "#1c1c1c")
 '(tabbar-separator (quote (1)))
 '(web-mode-code-indent-offset 2)
 '(web-mode-enable-auto-closing t)
 '(web-mode-enable-auto-indentation t)
 '(web-mode-markup-indent-offset 2)
 '(whitespace-global-modes (quote (python-mode)))
 '(whitespace-style
   (quote
    (face tabs spaces trailing lines space-before-tab newline indentation empty space-after-tab tab-mark)))
 '(yas-trigger-key "TAB"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#93a1a1"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#657b83" :slant italic))))
 '(font-lock-comment-face ((t (:foreground "#657b83" :slant italic))))
 '(git-gutter:added ((t (:bold t))))
 '(git-gutter:deleteed ((t (:bold t))))
 '(git-gutter:modified ((t (:bold t))))
 '(highlight ((t (:background "#cb4b16" :foreground "#fdf6e3"))))
 '(js2-function-param ((t (:foreground "Green"))))
 '(powerline-active1 ((t (:background "cyan" :foreground "brightwhite"))) t)
 '(powerline-active2 ((t (:inherit mode-line :background "brightwhite"))) t)
 '(tabbar-button ((t (:inherit tabbar-default))))
 '(tabbar-default ((t (:inherit variable-pitch :background "#657b83" :foreground "#262626" :height 1.0))))
 '(tabbar-modified ((t (:inherit tabbar-default :background "white"))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#002b26" :foreground "#a5e00f"))))
 '(tabbar-selected-modified ((t (:inherit tabbar-selected :background "white" :foreground "#d33682"))))
 '(tabbar-unselected ((t (:inherit tabbar-default))))
 '(whitespace-indentation ((((background dark) (type graphic)) (:background "#cb4b16")) (((background dark) (type tty) (min-colors 256)) (:background "#d75f00")) (((background dark) (type tty) (min-colors 16)) (:background "brightred")) (((background dark) (type tty) (min-colors 8)) (:background "red")) (((background light) (type graphic)) (:background "#cb4b16")) (((background light) (type tty) (min-colors 256)) (:background "#d75f00")) (((background light) (type tty) (min-colors 16)) (:background "brightred")) (((background light) (type tty) (min-colors 8)) (:background "red"))))
 '(whitespace-line ((((background dark) (type graphic)) (:foreground nil :background "#d33682")) (((background dark) (type tty) (min-colors 256)) (:foreground nil :background "#af005f")) (((background dark) (type tty) (min-colors 16)) (:foreground nil :background "magenta")) (((background dark) (type tty) (min-colors 8)) (:foreground nil :background "magenta")) (((background light) (type graphic)) (:foreground nil :background "#d33682")) (((background light) (type tty) (min-colors 256)) (:foreground nil :background "#af005f")) (((background light) (type tty) (min-colors 16)) (:foreground nil :background "magenta")) (((background light) (type tty) (min-colors 8)) (:foreground nil :background "magenta"))))
 '(whitespace-space ((t (:foreground "darkgray"))))
 '(whitespace-trailing ((((background dark) (type graphic)) (:background "#cb4b16")) (((background dark) (type tty) (min-colors 256)) (:background "#d75f00")) (((background dark) (type tty) (min-colors 16)) (:background "brightred")) (((background dark) (type tty) (min-colors 8)) (:background "red")) (((background light) (type graphic)) (:background "#cb4b16")) (((background light) (type tty) (min-colors 256)) (:background "#d75f00")) (((background light) (type tty) (min-colors 16)) (:background "brightred")) (((background light) (type tty) (min-colors 8)) (:background "red")))))
