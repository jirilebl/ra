#!/bin/zsh
echo Conversion to HTML through PreTeXt.  It is still beta quality and work in
echo progress.  The realanal-html.xsl assumes a fixed location for the PreTeXt
echo xsl file.  You need to edit this first.
echo Do ^C to get out.
echo
echo You should first run with --runpdft or --full to run the pdft figures.
echo
echo To rerun all figures first do \"rm "*-mbx.*" "*-mbxpdft.*"\", or run
echo this script with --kill-generated.
echo 

PDFT=no

# parse parameters
while [ "$1" != "" ]; do
    case $1 in
        -h | --help)
            exit
            ;;
        --runpdft)
	    echo "OPTION (runpdft) Will run pdf_t figures"
	    PDFT=yes
            ;;
        --full)
	    echo "OPTION (full) Will run pdf_t optimize svgs"
	    PDFT=yes
            ;;
        --kill-generated)
	    echo "OPTION (kill-generated) Killing generated figures and exiting (not killing -mbx.svg)."
	    cd figures
	    rm *-mbx.(svg|png)
	    rm *-mbxpdft.(svg|png)
	    cd ..
	    exit
	    ;;
        *)
            echo "ERROR: unknown parameter \"$1\""
            exit 1
            ;;
    esac
    shift
done


# wait for enter or ^C
echo "[Press Enter to run on Ctrl-C to bail out]"
read

if [ "$PDFT" = "yes" ] ; then
	echo
	echo RUNNING FIGURES...
	echo

	cd figures
	./figurerun.sh 192
	cd ..
fi

echo
echo RUNNING convert-to-mbx.pl ...
echo

perl convert-to-mbx.pl

echo
echo REMOVE doubled horizontal rules
echo

perl -0777 -i -pe 's:<rahr/>[ \r\n]*<rahr/>:<rahr/>:igs' ./realanal-out.xml

#xmllint --format -o realanal-out2.xml realanal-out.xml

echo
echo MOVING OLD html, CREATING NEW html, COPYING figures/ in there
echo

if [ -e html ] ; then
	mv html html.$RANDOM$RANDOM$RANDOM
fi
mkdir html
cd html
cp -a ../figures .
rm figures/.gitignore
rm figures/*.sh
rm figures/figurerun*
rm figures/figure-concat*
cp ../extra.css .
cp ../logo.png .

echo
echo RUNNING xsltproc
echo

xsltproc -stringparam publisher realanal-publisher.xml ../realanal-html.xsl ../realanal-out.xml

echo
echo Copy the _static things
echo

mkdir _static
mkdir _static/pretext
cp -a ~/pretext/js _static/pretext/
cp -a ~/pretext/css _static/pretext/
cp _static/pretext/css/dist/theme-default-modern.css _static/pretext/css/theme.css
#cp _static/pretext/css/dist/theme-default-modern.css.map _static/pretext/css/
cp -a ~/pretext/js_lib _static/pretext/js/lib


echo
echo FIXING UP HTML ...
echo

for n in *.html; do
	../fixup-html-file.pl < $n > tmpout
	mv tmpout $n
done

echo
echo DONE ...
echo
echo 'Perhaps now do (if you are me): rsync -av -e ssh html zinc.kvinzo.com:/var/www/jirka/ra/'
echo 'Make sure you have run the script with --full before ...'
echo
