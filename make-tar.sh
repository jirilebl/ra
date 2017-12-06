#!/bin/sh
FILES=`git ls-files | grep -v '^D$' | grep -v '.cvsignore' | grep -v 'make-tar.sh' | grep -v 'publish.sh' | grep -v 'publish2.sh'`

rm -fR realanal
mkdir realanal
cp $FILES realanal

rm -f realanal.tar.gz
tar cvf realanal.tar realanal/
gzip -9 realanal.tar

rm -fR realanal
