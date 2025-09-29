#!/bin/zsh
echo Conversion to HTML through PreTeXt.  It is still beta quality and work in
echo progress.  The realanal-html.xsl assumes a fixed location for the PreTeXt
echo xsl file.  You need to edit this first.
echo Do ^C to get out.
echo
echo You should first run with --runpdft --optimize-svg which
echo runs the pdft figures and then also optimizes svgs.  Without
echo --runpdft some figures will be missing.  You can also use --full
echo which does all three arguments.
echo Optimizations are in optimize-svgs.sh in figures/
#echo You should first run with --runpdft --optimize-svg which
#echo runs the pdft figures and then also optimizes svgs.  Without
#echo --runpdft some figures will be missing.  You can also use --full
#echo which does both arguments.
echo You should first run with --runpdft
echo Optimizations are in optimize-svgs.sh in figures/
echo "But optimization (svgo) is buggy."
echo
#echo To rerun all figures first do \"rm "*-mbx.*" "*-mbxpdft.*"\", or run
echo To rerun all .fig figures to pdf and svg first
echo do \"rm "figures/*-mbxpdft.*"\", or run
echo this script with --kill-generated.
echo 
echo Normally, the normal figure svg figures are not remade from the
echo pdfs, to redo them, first do \"rm "figures/*-mbx.*"\".
echo These are in git normally.
echo Beware that svgo may be a bit buggy so good to check the output.
echo

if [ x`svgo -v` != "x3.0.4" ]; then
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo 
	echo svgo at the incorrect version, do "sudo install -g svgo@3.0.4"
	echo other versions seem to eat content
	echo 
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
fi

PDFT=no
#OPTPNG=no
#OPTSVG=no

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
#        --optimize-png)
#	    echo "OPTION (optimize-png) Will run optimize-pngs.sh"
#	    OPTPNG=yes
#            ;;
#        --optimize-svg)
#	    echo "OPTION (optimize-svg) Will run optimize-svgs.sh"
#	    OPTSVG=yes
#	    ;;
        --full)
	    echo "OPTION (full) Will run pdf_t optimize svgs"
	    PDFT=yes
	    #OPTPNG=yes
	    #OPTSVG=yes
            ;;
        --kill-generated)
	    echo "OPTION (kill-generated) Killing generated figures and exiting (not killing -mbx.svg)."
	    cd figures
	    #rm *-mbx.(svg|png)
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

#if [ "$OPTSVG" = "yes" ] ; then
#	echo
#	echo OPTIMIZING SVG...
#	echo
#
#	cd figures
#	./optimize-svgs.sh
#	cd ..
#fi

echo
echo MOVING OLD html, CREATING NEW html, COPYING figures/ in there
echo

if [ -e html ] ; then
	mv html html.$RANDOM$RANDOM$RANDOM
fi
mkdir html
cd html
cp -a ../figures .
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
