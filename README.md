# company-indentpro - Emacs mdoe and company completion backend for .indent.pro files

*Author:* Noah Peart <noah.v.peart@gmail.com><br>
*URL:* [https://github.com/nverno/company-indent-pro](https://github.com/nverno/company-indent-pro)<br>

Emacs mode and autocompletion backend (using `company-mode`) for .indent.pro files.

Installation:

Install `company-mode` and add this file to `load-path`.  Then either compile/create autoloads and load autoloads files, or require the file in your init file.

```lisp
(require 'indentpro-mode)

;; Add a hook to use company-completion
(add-hook 'indentpro-mode-hook
          #'(lambda ()
              (set (make-local-variable 'company-backends)
                   '(company-indentpro))))
```


---
Converted from `indentpro-mode.el` by [*el2markdown*](https://github.com/Lindydancer/el2markdown).
