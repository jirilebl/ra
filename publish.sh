#!/bin/sh
# This is really overly anal, but at least 4 runs seem to be needed with
# the ogx, so better be safe and run it 5 times
pdflatex realanal
pdflatex realanal
pdflatex realanal
pdflatex realanal
pdflatex realanal
# We are now using imakeidx and [automake] in glossaries
# so no need to run these separately
