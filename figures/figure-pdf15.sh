#!/bin/sh
cp -f $1 $1.bak
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/prepress -sOutputFile=".foo.pdf" "$1" && cp .foo.pdf $1 && rm -f .foo.pdf
