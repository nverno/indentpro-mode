# company-indentpro - Emacs mdoe and company completion backend for .indent.pro files

*Author:* Noah Peart <noah.v.peart@gmail.com><br>
*URL:* [https://github.com/nverno/company-indent-pro](https://github.com/nverno/company-indent-pro)<br>

This file is not part of GNU Emacs.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 3, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301, USA.

Description:

Simple emacs major mode for editing .indent.pro files.  Mostly, just
an interface to autocompletion, because there are too many acrynyms
to remember, completion support can be found at
[company-indentpro](https://github.com/nverno/company-indentpro).

It also adds font-locking and c/c++ comment syntax.

Installation:

Just add this file to `load-path` and require it or compile and
make autoloads, then load the autoloads files in your init file.
The simple way:

```lisp
(require 'indentpro-mode)
```


---
Converted from `indentpro-mode.el` by [*el2markdown*](https://github.com/Lindydancer/el2markdown).
