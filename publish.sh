#!/bin/sh
# This is really overly anal, but at least 4 runs seem to be needed with
# the ogx, so better be safe and run it 5 times, also automake in glossaries
# doesn't seem to always work
for n in 1 2 3 4; do
  pdflatex realanal
  makeindex realanal
  makeglossaries realanal
done
pdflatex realanal
# We are now using imakeidx and [automake] in glossaries
# so no need to run these separately (FIXME: doesn't seem to work
# on one of my machines, that's why the run above, I've added makeindex
# just for good measure there)
