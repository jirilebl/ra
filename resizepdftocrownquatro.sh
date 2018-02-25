#!/bin/sh
gs \
 -sOutputFile="$1"-cq.pdf \
 -sDEVICE=pdfwrite \
 -r720 \
 -g5356x6976 \
 -dCompatibilityLevel=1.5 \
 -dNOPAUSE \
 -dBATCH \
 -dPDFFitPage \
  "$1".pdf

#-sPAPERSIZE=a4 \
