#!/bin/sh
FILES=`git ls-files | grep -v '.gitignore' | grep -v 'make-tar.sh'`

rm -fR realanal
mkdir realanal
cp $FILES realanal

rm -f realanal.tar.gz
tar cvf realanal.tar realanal/
gzip -9 realanal.tar

rm -fR realanal
