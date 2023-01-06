#!/bin/sh
echo Building

for n in *.tex ; do
	echo =============================
	p=`basename $n .tex`".pdf"
	echo $n '-->' $p
	rubber -d $n
done

echo =============================
echo Making raslides.zip

rm -f raslides.zip
zip raslides *.pdf
