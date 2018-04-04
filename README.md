Basic Analysis: Introduction to Real Analysis
---------------------------------------------

A free online textbook.  See http://www.jirka.org/ra/

Volume I and II are both in this directory

* realanal.tex is Volume I
* realanal2.tex is Volume II
* The files above are just the "driver files", the actual contents are in the files ch-???.tex
* realanal.tex must be complied first as realanal2.tex uses the realanal.aux file

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

Work in progress stuff:

* wip/realanal3.tex is an unfinished set of topics possibly to just add to Volume II
* similarly wip/extras.tex and wip/stieltjes.tex

On the scripts:

* publish.sh compiles the volume I file to pdf
* publish2.sh compiles the volume II file to pdf
* resizetocrownquatro.sh resize a PDF to crown quatro size using ghostscript

*Note:* The tex sources require a very recent LaTeX.  If your latex does not
have a recent enough ocgx2 package, you can simply comment out that line in
the preamble.  Another is the glossaries, which has a bug until very recently,
to do with sorting.  If you are getting undefined errors while compiling,
take out the "sort=use" option from the glossaries package.
