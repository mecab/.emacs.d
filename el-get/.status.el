((anything status "installed" recipe
	   (:name anything :website "http://www.emacswiki.org/emacs/Anything" :description "Open anything / QuickSilver-like candidate-selection framework" :type git :url "http://repo.or.cz/r/anything-config.git" :shallow nil :load-path
		  ("." "extensions" "contrib")
		  :features anything))
 (auctex status "installed" recipe
	 (:name auctex :type elpa :after nil :depends
		(s)))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :website "http://elpa.gnu.org/packages/cl-lib.html"))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (color-theme-solarized status "installed" recipe
			(:name color-theme-solarized :description "Emacs highlighting using Ethan Schoonover's Solarized color scheme" :type github :pkgname "sellout/emacs-color-theme-solarized" :depends color-theme :prepare
			       (progn
				 (add-to-list 'custom-theme-load-path default-directory)
				 (autoload 'color-theme-solarized-light "color-theme-solarized" "color-theme: solarized-light" t)
				 (autoload 'color-theme-solarized-dark "color-theme-solarized" "color-theme: solarized-dark" t))))
 (company-mode status "installed" recipe
	       (:name company-mode :website "http://company-mode.github.io/" :description "Modular in-buffer completion framework for Emacs" :type github :pkgname "company-mode/company-mode"))
 (company-statistics status "installed" recipe
		     (:name company-statistics :type github :pkgname "company-mode/company-statistics" :after nil))
 (company-tern status "installed" recipe
	       (:name company-tern :description "Tern backend for company-mode." :type github :pkgname "proofit404/company-tern" :depends
		      (dash company-mode s tern)
		      :post-init
		      (eval-after-load 'company
			'(add-to-list 'company-backends 'company-tern))))
 (company-web status "installed" recipe
	      (:name company-web :description "Company-web is an alternative emacs plugin for autocompletion in html-mode, web-mode, jade-mode, slim-mode and use data of ac-html. It uses company-mode." :website "https://github.com/osv/company-web" :type github :depends
		     (company-mode dash cl-lib web-completion-data)
		     :pkgname "osv/company-web"))
 (ctable status "installed" recipe
	 (:name ctable :description "Table Component for elisp" :type github :pkgname "kiwanami/emacs-ctable"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (deferred status "installed" recipe
   (:name deferred :description "Simple asynchronous functions for emacs lisp." :type github :pkgname "kiwanami/emacs-deferred"))
 (descbinds-anything status "installed" recipe
		     (:name descbinds-anything :description "Yet Another describe-bindings with anything" :type emacswiki :depends anything :features descbinds-anything))
 (direx status "installed" recipe
	(:name direx :description "Directory Explorer" :type github :pkgname "m2ym/direx-el"))
 (docker status "installed" recipe
	 (:name docker :description "Manage docker images & containers from Emacs" :type github :pkgname "Silex/docker.el" :depends
		(magit s dash docker-tramp tablist json-mode)))
 (docker-tramp status "installed" recipe
	       (:name docker-tramp :description "TRAMP integration for docker containers" :type github :pkgname "emacs-pe/docker-tramp.el"))
 (dockerfile-mode status "installed" recipe
		  (:name dockerfile-mode :description "An emacs mode for handling Dockerfiles." :type github :pkgname "spotify/dockerfile-mode" :depends
			 (s)
			 :prepare
			 (progn
			   (add-to-list 'auto-mode-alist
					'("Dockerfile\\'" . dockerfile-mode)))))
 (dumb-jump status "installed" recipe
	    (:name dumb-jump :type github :pkgname "jacktasia/dumb-jump" :after nil))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:features el-get :post-init
		(when
		    (memq 'el-get
			  (bound-and-true-p package-activated-list))
		  (message "Deleting melpa bootstrap el-get")
		  (unless package--initialized
		    (package-initialize t))
		  (when
		      (package-installed-p 'el-get)
		    (let
			((feats
			  (delete-dups
			   (el-get-package-features
			    (el-get-elpa-package-directory 'el-get)))))
		      (el-get-elpa-delete-package 'el-get)
		      (dolist
			  (feat feats)
			(unload-feature feat t))))
		  (require 'el-get))))
 (emacs-async status "installed" recipe
	      (:name emacs-async :description "Simple library for asynchronous processing in Emacs" :type github :pkgname "jwiegley/emacs-async"))
 (emmet-mode status "installed" recipe
	     (:name emmet-mode :website "https://github.com/smihica/emmet-mode" :description "Produce HTML from CSS-like selectors." :type "github" :branch "master" :pkgname "smihica/emmet-mode"))
 (epc status "installed" recipe
      (:name epc :description "An RPC stack for Emacs Lisp" :type github :pkgname "kiwanami/emacs-epc" :depends
	     (deferred ctable)))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (exec-path-from-shell status "installed" recipe
		       (:name exec-path-from-shell :website "https://github.com/purcell/exec-path-from-shell" :description "Emacs plugin for dynamic PATH loading" :type github :pkgname "purcell/exec-path-from-shell"))
 (expand-region status "installed" recipe
		(:name expand-region :type github :pkgname "magnars/expand-region.el" :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want." :website "https://github.com/magnars/expand-region.el#readme"))
 (f status "installed" recipe
    (:name f :website "https://github.com/rejeep/f.el" :description "Modern API for working with files and directories in Emacs" :depends
	   (s dash)
	   :type github :pkgname "rejeep/f.el"))
 (fancy-narrow status "installed" recipe
	       (:name fancy-narrow :description "Emacs package to immitate narrow-to-region with more eye-candy" :type github :pkgname "Bruce-Connor/fancy-narrow"))
 (flycheck status "installed" recipe
	   (:name flycheck :type github :pkgname "flycheck/flycheck" :minimum-emacs-version "24.3" :description "On-the-fly syntax checking extension" :depends
		  (dash pkg-info let-alist seq)))
 (flymake-easy status "installed" recipe
	       (:name flymake-easy :type github :description "Helpers for easily building flymake checkers" :pkgname "purcell/flymake-easy" :website "http://github.com/purcell/flymake-easy"))
 (fringe-helper status "installed" recipe
		(:name fringe-helper :description "Helper functions for fringe bitmaps." :type github :pkgname "nschum/fringe-helper.el"))
 (gh status "installed" recipe
     (:name gh :description "Github API client libraries" :type github :pkgname "sigma/gh.el" :depends
	    (pcache logito request marshal s)
	    :autoloads nil))
 (ghub status "installed" recipe
       (:name ghub :type github :description "Minuscule client for the Github API" :pkgname "magit/ghub" :depends
	      (graphql treepy)))
 (ginger-api status "installed" recipe
	     (:name ginger-api :type git :url "https://gist.github.com/5457732.git" :after nil))
 (ginger-rephrase-api status "installed" recipe
		      (:name ginger-rephrase-api :type git :url "https://gist.github.com/7349439.git" :after nil))
 (gist status "installed" recipe
       (:name gist :type github :pkgname "defunkt/gist.el" :depends
	      (gh tabulated-list)
	      :description "Emacs integration for gist.github.com" :website "http://github.com/defunkt/gist.el"))
 (git-gutter status "installed" recipe
	     (:name git-gutter :description "Emacs port of GitGutter Sublime Text 2 Plugin" :website "https://github.com/syohex/emacs-git-gutter" :type github :pkgname "syohex/emacs-git-gutter"))
 (git-timemachine status "installed" recipe
		  (:name git-timemachine :description "Step through historic versions of git controlled file using everyone's favourite editor" :type git :url "https://gitlab.com/pidu/git-timemachine" :minimum-emacs-version "24"))
 (graphql status "installed" recipe
	  (:name graphql :description "GraphQL.el provides a set of generic functions for interacting with GraphQL web services." :type github :pkgname "vermiculus/graphql.el"))
 (highlight-symbol status "installed" recipe
		   (:name highlight-symbol :description "Quickly highlight a symbol throughout the buffer and cycle through its locations." :type github :pkgname "nschum/highlight-symbol.el"))
 (ht status "installed" recipe
     (:name ht :website "https://github.com/Wilfred/ht.el" :description "The missing hash table utility library for Emacs." :type github :pkgname "Wilfred/ht.el"))
 (js2-mode status "installed" recipe
	   (:name js2-mode :website "https://github.com/mooz/js2-mode#readme" :description "An improved JavaScript editing mode" :type github :pkgname "mooz/js2-mode" :prepare
		  (autoload 'js2-mode "js2-mode" nil t)))
 (json-mode status "installed" recipe
	    (:name json-mode :description "Major mode for editing JSON files, extends the builtin js-mode to add better syntax highlighting for JSON." :type github :pkgname "joshwnj/json-mode" :depends
		   (json-snatcher json-reformat)))
 (json-reformat status "installed" recipe
		(:name json-reformat :description "Reformatting tool for JSON." :type github :pkgname "gongo/json-reformat"))
 (json-snatcher status "installed" recipe
		(:name json-snatcher :description "Find the path to a value in JSON" :type github :pkgname "Sterlingg/json-snatcher"))
 (let-alist status "installed" recipe
	    (:name let-alist :description "Easily let-bind values of an assoc-list by their names." :builtin "25.0.50" :type elpa :website "https://elpa.gnu.org/packages/let-alist.html"))
 (log4e status "installed" recipe
	(:name log4e :website "https://github.com/aki2o/log4e" :description "provide logging framework for elisp." :type github :pkgname "aki2o/log4e"))
 (logito status "installed" recipe
	 (:name logito :type github :pkgname "sigma/logito" :description "logging library for Emacs" :website "http://github.com/sigma/logito"))
 (lsp-mode status "installed" recipe
	   (:name lsp-mode :website "https://github.com/emacs-lsp/lsp-mode" :description "Emacs client/library for the Language Server Protocol" :depends
		  (dash f ht spinner)
		  :type github :pkgname "emacs-lsp/lsp-mode"))
 (magit status "installed" recipe
	(:name magit :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :branch "master" :minimum-emacs-version "25.1" :depends
	       (dash transient with-editor)
	       :info "Documentation" :load-path "lisp/" :compile "lisp/" :build
	       `(("make" ,(format "EMACSBIN=%s" el-get-emacs)
		  "docs")
		 ("touch" "lisp/magit-autoloads.el"))
	       :build/berkeley-unix
	       `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
		  "docs")
		 ("touch" "lisp/magit-autoloads.el"))
	       :build/windows-nt
	       (with-temp-file "lisp/magit-autoloads.el" nil)))
 (magit-popup status "installed" recipe
	      (:name magit-popup :website "https://github.com/magit/magit-popup" :description "Define prefix-infix-suffix command combos" :type github :pkgname "magit/magit-popup" :depends
		     (dash)))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :website "http://jblevins.org/projects/markdown-mode/" :type github :pkgname "jrblevin/markdown-mode" :prepare
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (marshal status "installed" recipe
	  (:name marshal :description "EIEIO marshalling, inspired by Go tagged structs." :type github :pkgname "sigma/marshal.el" :depends
		 (ht)))
 (neotree status "installed" recipe
	  (:name neotree :website "https://github.com/jaypei/emacs-neotree" :description "An Emacs tree plugin like NerdTree for Vim." :type github :branch "master" :pkgname "jaypei/emacs-neotree"))
 (nvm status "installed" recipe
      (:name nvm :type elpa :after nil))
 (open-junk-file status "installed" recipe
		 (:name open-junk-file :description "Open a junk (memo) file to try-and-error" :type emacswiki :features "open-junk-file"))
 (org-journal status "installed" recipe
	      (:name org-journal :type github :pkgname "bastibe/org-journal" :after nil))
 (osc52e status "installed" recipe
	 (:name osc52e :type git :url "https://gist.github.com/49eabc1978fe3d6dedb3ca5674a16ece.git" :after nil))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "https://repo.or.cz/w/emacs.git/blob_plain/ba08b24186711eaeb3748f3d1f23e2c2d9ed0d09:/lisp/emacs-lisp/package.el" :features package :post-init
		 (progn
		   (let
		       ((old-package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))))
		     (when
			 (file-directory-p old-package-user-dir)
		       (add-to-list 'package-directory-list old-package-user-dir)))
		   (setq package-archives
			 (bound-and-true-p package-archives))
		   (let
		       ((protocol
			 (if
			     (and
			      (fboundp 'gnutls-available-p)
			      (gnutls-available-p))
			     "https://"
			   (lwarn
			    '(el-get tls)
			    :warning "Your Emacs doesn't support HTTPS (TLS)%s"
			    (if
				(eq system-type 'windows-nt)
				",\n  see https://github.com/dimitri/el-get/wiki/Installation-on-Windows." "."))
			   "http://"))
			(archives
			 '(("melpa" . "melpa.org/packages/")
			   ("gnu" . "elpa.gnu.org/packages/")
			   ("marmalade" . "marmalade-repo.org/packages/"))))
		     (dolist
			 (archive archives)
		       (add-to-list 'package-archives
				    (cons
				     (car archive)
				     (concat protocol
					     (cdr archive)))))))))
 (pcache status "installed" recipe
	 (:name pcache :description "persistent caching for Emacs" :type github :pkgname "sigma/pcache"))
 (php-mode-improved status "installed" recipe
		    (:name php-mode-improved :description "Major mode for editing PHP code. This is a version of the php-mode from http://php-mode.sourceforge.net that fixes a few bugs which make using php-mode much more palatable" :type emacswiki :load
			   ("php-mode-improved.el")
			   :features php-mode))
 (pkg-info status "installed" recipe
	   (:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
		  (dash epl)))
 (popwin status "installed" recipe
	 (:name popwin :description "Popup Window Manager." :website "https://github.com/m2ym/popwin-el" :type github :pkgname "m2ym/popwin-el" :load-path
		("." "misc")))
 (pos-tip status "installed" recipe
	  (:name pos-tip :description "Show tooltip at point" :type github :pkgname "pitkali/pos-tip"))
 (python-environment status "installed" recipe
		     (:name python-environment :description "Python virtualenv API for Emacs Lisp" :type github :pkgname "tkf/emacs-python-environment" :depends
			    (deferred)))
 (python-mode status "installed" recipe
	      (:name python-mode :type elpa :after nil))
 (rainbow-delimiters status "installed" recipe
		     (:name rainbow-delimiters :website "https://github.com/Fanael/rainbow-delimiters#readme" :description "Color nested parentheses, brackets, and braces according to their depth." :type github :pkgname "Fanael/rainbow-delimiters"))
 (request status "installed" recipe
	  (:name request :description "Easy HTTP request for Emacs Lisp" :type github :submodule nil :pkgname "abingham/emacs-request" :depends
		 (deferred)
		 :provide
		 (request-deferred)))
 (s status "installed" recipe
    (:name s :description "The long lost Emacs string manipulation library." :type github :pkgname "magnars/s.el"))
 (scss-mode status "installed" recipe
	    (:name scss-mode :description "Major mode for editing SCSS files(http://sass-lang.com)" :type github :pkgname "antonj/scss-mode"))
 (seq status "installed" recipe
      (:name seq :description "Sequence manipulation functions" :builtin "25" :type elpa :website "https://elpa.gnu.org/packages/seq.html"))
 (shell-pop status "installed" recipe
	    (:name shell-pop :description "Helps you pop up and pop out shell buffer easily." :website "https://github.com/kyagi/shell-pop-el" :type github :pkgname "kyagi/shell-pop-el"))
 (simple-httpd status "installed" recipe
	       (:name simple-httpd :description "A simple Emacs web server" :type github :pkgname "skeeto/emacs-http-server"))
 (skewer-mode status "installed" recipe
	      (:name skewer-mode :description "Provides live interaction with JavaScript, CSS, and HTML in a web browser" :type github :pkgname "skeeto/skewer-mode" :depends
		     (js2-mode simple-httpd)
		     :features skewer-setup :post-init
		     (skewer-setup)))
 (solidity-mode status "installed" recipe
		(:name solidity-mode :description "Language mode for Ethereum's Solidity Language" :type github :website "https://github.com/ethereum/emacs-solidity" :pkgname "ethereum/emacs-solidity"))
 (spinner status "installed" recipe
	  (:name spinner :description "Emacs mode-line spinner for operations in progress." :type github :pkgname "Bruce-Connor/spinner.el"))
 (tabbar status "installed" recipe
	 (:name tabbar :description "Display a tab bar in the header line." :type github :pkgname "dholm/tabbar" :lazy t))
 (tablist status "installed" recipe
	  (:name tablist :description "Extended Emacs tabulated-list-mode." :website "https://github.com/politza/tablist" :type github :pkgname "politza/tablist"))
 (tabulated-list status "installed" recipe
		 (:name tabulated-list :type github :pkgname "sigma/tabulated-list.el" :description "generic major mode for tabulated lists." :website "http://github.com/sigma/tabulated-list.el"))
 (tern status "installed" recipe
       (:name tern :type elpa :after nil))
 (transient status "installed" recipe
	    (:name transient :website "https://github.com/magit/transient#readme" :description "Transient commands used by magit." :type github :pkgname "magit/transient" :branch "master" :minimum-emacs-version "25.1" :depends
		   (dash)
		   :info "docs" :load-path "lisp/" :compile "lisp/" :build
		   `(("make" ,(format "EMACSBIN=%s" el-get-emacs)
		      "info"))
		   :build/berkeley-unix
		   `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
		      "info"))))
 (treepy status "installed" recipe
	 (:name treepy :description "A set of generic functions for traversing tree-like data structures recursively and/or iteratively." :type github :pkgname "volrath/treepy.el"))
 (virtualenvwrapper status "installed" recipe
		    (:name virtualenvwrapper :type github :website "https://github.com/porterjamesj/virtualenvwrapper.el" :description "virtualenv tool for emacs" :pkgname "porterjamesj/virtualenvwrapper.el" :depends
			   (dash s)))
 (web-completion-data status "installed" recipe
		      (:name web-completion-data :description "Shared completion data for ac-html and company-web" :type github :pkgname "osv/web-completion-data"))
 (web-mode status "installed" recipe
	   (:name web-mode :description "emacs major mode for editing PHP/JSP/ASP HTML templates (with embedded CSS and JS blocks)" :type github :pkgname "fxbois/web-mode"))
 (with-editor status "installed" recipe
	      (:name with-editor :description "Use the Emacsclient as $EDITOR" :type github :pkgname "magit/with-editor"))
 (yaml-mode status "installed" recipe
	    (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode"))
 (yasnippet status "installed" recipe
	    (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :compile "yasnippet.el" :submodule nil))
 (yaxception status "installed" recipe
	     (:name yaxception :website "https://github.com/aki2o/yaxception" :description "provide framework about exception like Java for elisp." :type github :pkgname "aki2o/yaxception")))
