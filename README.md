Basic Analysis: Introduction to Real Analysis
---------------------------------------------

Volume I and II both in this directory

* realanal.tex is Volume I
* realanal2.tex is Volume II

A free online textbook.  See http://www.jirka.org/ra/

* wip/realanal3.tex is an unfinished set of topics possibly to just add to Volume II
* similarly wip/extras.tex and wip/stieltjes.tex

Notes on figures:

* All figures are in figures/ directory for both volumes.
* Many figures in figures/ are epix figures (files ending in .xp), and there
  are two scripts run-xp-topdf.sh and run-all-xp.sh that compile the figures.
  If you modify fonts or font sizes and want to rerun the figures, make sure to
  have epix installed, modify run-xp-topdf.sh and then run ./run-all-xp.sh in
  the figures/ directory
* The other type of figures were created with xfig (files ending in .fig), and
  then exported to PDF/LaTeX which generates a .pdf_t file that is just included
  in the latex file and contains all text, and a .pdf file which contains the
  graphics.  You need xfig to edit these, then export to
  "Combined PDF/LaTeX (both parts)"

On the scripts:

* publish.sh compiles the volume I file to pdf
* publish2.sh compiles the volume II file to pdf
* make-tar.sh makes a tarball

Note that the tex sources require a very recent LaTeX, if your latex does not
have a recent enough ocgx2 package, you can simply comment out that line in
the preamble.
