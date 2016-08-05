;;; company-indentpro.el --- Emacs mdoe and company completion backend for .indent.pro files.

;; Author: Noah Peart <noah.v.peart@gmail.com>
;; URL: https://github.com/nverno/company-indent-pro
;; Package-Requires ((company "0.8.0") (cl-lib "0.5.0"))
;; Copyright (C) 2016, Noah Peart, all rights reserved.
;; Created:  5 August 2016

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:

;; Emacs mode and autocompletion backend (using `company-mode') for .indent.pro files.

;;; Installation:

;; Install `company-mode' and add this file to `load-path'.  Then either compile/create autoloads and load autoloads files, or require the file in your init file.

;; ```lisp
;; (require 'indentpro-mode)

;; ;; Add a hook to use company-completion
;; (add-hook 'indentpro-mode-hook
;;           #'(lambda ()
;;               (set (make-local-variable 'company-backends)
;;                    '(company-indentpro))))
;; ```

;;; Code:

(require 'company)

;; ------------------------------------------------------------
;;* Mode

;;;###autoload
(define-derived-mode indentpro-mode conf-mode "Indent Pro"
  "Major mode for .indent.pro files.\n")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.indent\\.pro\\'" . indentpro-mode))

;; ------------------------------------------------------------
;;* Completion
(defvar company-indentpro-modes '(indentpro-mode))
(defvar company-indentpro-candidates nil)

(defun company-indentpro-build ()
  "Build candidate list."
  (let (res short long)
    (with-temp-buffer
      (call-process "man" nil t nil "indent")
      (goto-char (point-min))
      (re-search-forward "^OPTIONS")
      (forward-line 1)
      (while (looking-at-p "\\s-")
        (if 
            (re-search-forward
             "\\s-+\\(-[A-Za-z]+\\),?\\s-*\\(-[-A-Za-z]+\\)?"
             (line-end-position) t)
            (progn
              (setq short (match-string-no-properties 1))
              (setq long (match-string-no-properties 2))
              (forward-line 1)
              (goto-char (line-beginning-position))
              (re-search-forward "\\s-+\\(.*\\)$" (line-end-position) t)
              (when long
                (set-text-properties 0 1
                                     `(annot
                                       ,temp
                                       meta
                                       ,(match-string-no-properties 1))
                                     long)
                (push long res))
              (put-text-property 0 1 'meta
                                 (match-string-no-properties 1) short)
              (push short res))
          (forward-line 1))))
    (setq company-indentpro-candidates res)
    res))

(company-indentpro-build)
(sort company-indentpro-candidates 'string<)

(defun company-indentpro-prefix ()
  (and (derived-mode-p major-mode company-indentpro-modes)
       (not (company-in-string-or-comment))
       (company-grab-symbol)))

(defun company-indentpro-meta (candidate)
  (get-text-property 0 'meta candidate))

(defun company-indentpro-doc (candidate)
  (with-temp-buffer
    (call-process "man" nil t nil "indent")
    (goto-char (point-min))
    (company-doc-buffer
     (buffer-substring-no-properties (line-beginning-position)
                                     (point-max))))
  (get-buffer "*company-documentation*")
  (goto-char (search-forward candidate)))

(defun company-indentpro-annotation (arg))
(defun company-indentpro-candidates ())

;;;###autoload
(defun company-indentpro (command &optional arg &rest _args)
  "Indent pro backend for `company-mode'."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-indentpro))
    (prefix (company-indentpro-prefix))
    (annotation (company-indentpro-annotation arg))
    (meta (company-indentpro-meta arg))
    (doc-buffer (company-indentpro-doc arg))
    (sorted t)
    (candidates ())))

(provide 'indentpro-mode)

;;; company-indentpro.el ends here
