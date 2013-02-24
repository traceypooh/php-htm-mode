;; color whenever possible
(global-font-lock-mode 1)


;; for "-nw" mode, only 8 colors possible i guess:
;;     black  blue  cyan  green  magenta  red  white  yellow
;; and we can pick from these vars to color our programs/scripts:
;;
;; font-lock-builtin-face                  
;; font-lock-comment-delimiter-face
;; font-lock-comment-face                  
;; font-lock-constant-face
;; font-lock-doc-face                      
;; font-lock-face-attributes
;; font-lock-function-name-face            
;; font-lock-keyword-face
;; font-lock-negation-char-face            
;; font-lock-preprocessor-face
;; font-lock-reference-face                
;; font-lock-string-face
;; font-lock-syntactic-face-function       
;; font-lock-type-face
;; font-lock-variable-name-face            
;; font-lock-warning-face

(set-foreground-color "white")
(set-background-color "black");; screen background
(set-mouse-color "red");; ptr/cursor color
(set-cursor-color "red");; ptr/cursor color

(setq font-lock-face-attributes
      '((font-lock-comment-face "magenta")
        (font-lock-comment-delimiter-face "magenta")
        (font-lock-function-name-face "red")
        (font-lock-string-face "cyan")
        (font-lock-keyword-face "yellow")
        (font-lock-constant-face "green")
        (font-lock-variable-name-face "green")
        )
      )




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     Pretty display stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tracey-text-mode ()
  "set indent on newline, auto-fill, show line numbers, color fonts, fill, tab-width 2"
  (local-set-key [return] 'newline-and-indent)
  ;;(turn-on-auto-fill)
  (line-number-mode 1)    ;;; Automagically enter line number in mode bar
  (font-lock-mode 1)
  (set-fill-column 78)


  (setq indent-tabs-mode nil)   ;; DON'T make TABs (convert to multiple <SPACE>)
  (setq tab-width 2)
  (setq sh-basic-offset 2)                   ;; only relevant for sh-mode
  (setq-default css-indent-width tab-width)  ;; only relevant for css-mode
  (setq-default css-indent-offset tab-width) ;; only relevant for css-mode
  (setq-default js-indent-level 2)           ;; only relevant for js-mode
)


(defun tracey-code-mode ()
  (tracey-text-mode)
  (setq c-basic-indent 2) ;; this is for js2-mode, actually, sigh...

  (if (eq emacs-major-version '24)
    (progn
      ;;;;;;;;;;  NOTE: requires emacs 24+
      ;; make it so auto-NEWLINE whenever type any of chars:   ; { }
      (electric-layout-mode t) 
      (set (make-local-variable 'electric-layout-rules) 
           '((?\; . after)
             (?\{ . after)
             (?\} . after)))
      (electric-indent-mode t) 
      (set (make-local-variable 'electric-indent-chars) (cons ?\; electric-indent-chars))
      ;;;;;;;;;;  NOTE: requires emacs 24+
)))

  


;;######################################################################
;; multi-mode for php   (PHP and HTM and JS intermixed)
;; multi-mode for bash  (bash and PHP intermixed)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (from: http://babble.10gen.com/Developer%20Setup )
;;  wget http://www.tex.ac.uk/tex-archive/support/iso-tex/multi-mode.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-library "/home/tracey/emacs/multi-mode.el")
(setq-default indent-tabs-mode nil)


(defun tracey-sh-mode ()
  (tracey-text-mode)
  (multi-mode 1
              'sh-mode
              '("<\?" php-mode)
              '("\?>" sh-mode)
              ))

;; maybe some day, add some crazy sh1t?
;; http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
(defun php-mmode () (interactive)
  (multi-mode 1
              'html-mode
              '("<\?" php-mode)
              '("<\?php" php-mode)
              '("\?>" html-mode)
              '("<script" js-mode)
              ;;'("\{\"" json-mode) ;; not quite ideal...
              '("</script>" html-mode)
              '("<style" css-mode)
              '("</style>" html-mode)
              ))




;; These mappings will setup a "peek" of the start of the file to see if it
;; matches one of them -- and if so, to flip on php-mmode (and *NOT* use
;; auto-mode-alist -- since php-mode (normal mode) can mangle that)
;; A bonus is that if a file doesn't have a .php or .inc file extension, these
;; will make the file automagically load into php mmode!
(setq magic-mode-alist (append magic-mode-alist '(("<\\?"               . php-mmode))))
(setq magic-mode-alist (append magic-mode-alist '(("../usr/bin/env php" . php-mmode))))
(setq magic-mode-alist (append magic-mode-alist '(("<html"              . php-mmode))))
(setq magic-mode-alist (append magic-mode-alist '(("<head"              . php-mmode))))
(setq magic-mode-alist (append magic-mode-alist '(("<body"              . php-mmode))))
(setq magic-mode-alist (append magic-mode-alist '(("<\\!DOCTYPE html"   . php-mmode))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multi-mode for php   (PHP and HTM and JS intermixed)
;; multi-mode for bash  (bash and PHP intermixed)
;;######################################################################

(setq sh-mode-hook              'tracey-sh-mode)
(setq js-mode-hook              'tracey-code-mode)
(setq js2-mode-hook             'tracey-code-mode)
(setq javascript-mode-hook      'tracey-code-mode)
(setq php-mode-hook             'tracey-text-mode)
(setq css-mode-hook             'tracey-code-mode)


(autoload 'php-mode "php-mode" "PHP mode." t) ;; only really needed for MacOSX

(setq default-tab-width 2)

(setq auto-mode-alist 
      (append auto-mode-alist 
              '(("\\.js$"   . js-mode)
                )))