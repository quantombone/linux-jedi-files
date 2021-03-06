;;This is the .emacs file of Tomasz Malisiewicz (tomasz@cmu.edu)
;; $Date: 2009/08/21 05:42:00 $
;; This file is under version control and I use this file on many
;; different systems including personal MacBook Pro and linux machines for work

;; Load Mac OS X customizations
;; Here we determine if we are on an apple system and load the
;; apple-specific files

;; lots of outdated modes in here that need cleanup
(require 'cl)
(defvar *emacs-load-start* (current-time))



(add-to-list 'load-path "~/linux-jedi-files/")
(require 'git)
;;(if (string-match "apple" system-configuration)
;;    (if (file-exists-p "~/linux-jedi-files/git.el")
;;        (load-file "~/linux-jedi-files/git")))


(if (string-match "apple" system-configuration)
    (if (file-exists-p "~/linux-jedi-files/.emacs_mac")
        (load-file "~/linux-jedi-files/.emacs_mac")))


;;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; show matching parentheses
(show-paren-mode 1)

;; set up my window title to reflect what i'm working on
(setq frame-title-format "Emacs: %b")

;; enable column number mode
(column-number-mode 1)

;; highlight selected text
(transient-mark-mode t)

;; set background to black and foreground to white if using X mode
(if (not (eq window-system nil))
    (progn (set-face-foreground 'default "white")
           (set-face-background 'default "black")))

;; always turn on syntax highlighting
(global-font-lock-mode 1)

(setq-default indent-tabs-mode nil)

(global-set-key "\C-c\C-c" 'compile)
(setq tex-command "pdflatex")
(setq tex-dvi-view-command "xdvi")
(setq latex-run-command "pdflatex")
(setq tex-view-command "/Applications/Preview.app/Contents/MacOS/Preview")

;; Load the emacs C++ customizations (undergrad c++ hacker galore)
(if (file-exists-p "~/linux-jedi-files/.emacs_cpp")
    (load-file "~/linux-jedi-files/.emacs_cpp"))

;; Load the emacs Matlab customizations
(if (file-exists-p "~/linux-jedi-files/.emacs_matlab")
    (load-file "~/linux-jedi-files/.emacs_matlab"))

;; this enables automatic scrolling inside a compilation-mode buffer
(setq compilation-scroll-output t)

;; arranging for Emacs to notice password prompts and turn off echoing for them
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)


(global-set-key "\C-h" 'backward-delete-char)
(define-key global-map "\C-h" 'backward-delete-char)

;; follow symlinks since lots of my personal files are cvs-ed
(setq vc-follow-symlinks t)

(put 'downcase-region 'disabled nil)

;; for color inside my "inside-emacs shells"
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;Set command history to something large, since I often want a lot
;of history when hacking in MATLAB
(setq comint-input-ring-size 1024)

;; for text modes turn on auto line wrapping and spell checking mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(setq TeX-PDF-mode t)

;; (defun pdfevince ()
;;    (add-to-list 'TeX-output-view-style 
;;                     (quote ("^pdf$" "." "/Applications/Preview.app/Contents/MacOS/Preview %o %(outpage)")))
;; )

;; (add-hook  'LaTeX-mode-hook  'pdfevince  t) 

;;inhibit startup message
(setq inhibit-startup-message t)

(setq php-file "~/linux-jedi-files/php-mode.el")
(if (file-exists-p php-file)
    (load-file php-file))


;; graphviz stuff
(setq graphviz-file "~/linux-jedi-files/graphviz-dot-mode.el")
(if (file-exists-p graphviz-file)
    (load-file graphviz-file))

;; js2 stuff
(setq javascript-file "~/linux-jedi-files/js2-mode.el")
(if (file-exists-p javascript-file)
    (progn
      (autoload 'js2-mode javascript-file nil t)
      (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))

(put 'erase-buffer 'disabled nil)

;;(require 'smart-compile)
;;(global-set-key (kbd "C-<f12>") 'smart-compile)
;; (defcustom smart-compile-alist '(
;;   (emacs-lisp-mode    . (emacs-lisp-byte-compile))
;;   (html-mode          . (browse-url-of-buffer))

;;   (shell-script-mode . "bash %f")))



;; chmod +x
;; ref. http://homepage.mac.com/zenitani/elisp-j.html#chmod
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(global-set-key "\C-x\C-m" 'execute-extended-command)


;(require 'linum)
; (defun toggle-linum-mode ()
;      (interactive)
;      (if linum-mode
;        (linum-mode -1)
;        (linum-mode 1)))

;(global-set-key "\C-c\C-n" 'toggle-linum-mode)


;; Add this path, since we need it for git
(setenv "PATH" (concat "/usr1/users/tmalisie/git/bin/:"
                (getenv "PATH")))

(setq visible-bell t)


(message "My .emacs loaded in %ds" (destructuring-bind (hi lo ms) (current-time)
                           (- (+ hi lo) (+ (first *emacs-load-start*) (second *emacs-load-start*)))))
