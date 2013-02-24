php-htm-mode
============

php + html + javascript + css mixed editing via mutli-mode (multiple major modes).  

Has indenting, coloring, normal modes syntax parsing, etc.

Has some auto-newline and indent features for JS/CSS/PHP


Assumes and works best with emacs v24+
but will try to "gracefully degrade" for earlier versions.



Example usage setup:
* cd $HOME;
* git clone git://github.com/traceypooh/php-htm-mode.git;

* Add these lines to your $HOME/.emacs:
<code><br>
(load-library (concat (getenv "HOME") "/php-htm-mode/multi-mode.el"))<br>
(load-library (concat (getenv "HOME") "/php-htm-mode/php-htm-mode.el"))
</code>
