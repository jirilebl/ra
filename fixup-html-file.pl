#!/usr/bin/perl

# This is hackish, but I can't figure out how to modify the html output otherwise

my ($arg) = @ARGV;

$didaddbuttons = 0;
$didmathjaxconfig = 0;
$didheadstyleadd = 0;
$didprintwarn = 0;

$isindex = 0;

while($line = <STDIN>)
{
	$line =~ s{<span[^>]*><button id="light-dark-button".*</button></span>}{};
	if ($line =~ m/<title>[A-Za-z ]*Index<\/title>/) {
	  	$isindex = 1;
	}
	# This is the redirect page, do not do anything to it
	if ($line =~ m/<meta http-equiv.*refresh.*0; URL=.*>/) {
		print $line;
		while($line = <STDIN>) {
			print $line;
		}
	 	exit 0;
	}
	if ($line =~ m/<a class="index-button.*title="Index"/) {
		# Add extra buttons
		$extra = "<a class=\"index-button button\" href=\"..\" title=\"Home\" alt=\"Book Home\"><span class=\"name\">Home</span></a>\n";

		$extra .= "<a class=\"index-button button\" href=\"../realanal.pdf\" title=\"PDF\"><span class=\"name\">PDF(I)</span></a>\n";

		$extra .= "<a class=\"index-button button\" href=\"../realanal2.pdf\" title=\"PDF\"><span class=\"name\">PDF(II)</span></a>\n";

		##FIXME: add paperback buttons
		$extra .= "<a class=\"index-button button\" href=\"https://www.amazon.com/dp/B0C9S99TKF\" title=\"Paperback\" alt=\"Buy Paperback\"><span class=\"name\">Book(I)</span></a>\n";

		$extra .= "<a class=\"index-button button\" href=\"https://www.amazon.com/dp/B0C9S7P6M8\" title=\"Paperback\" alt=\"Buy Paperback\"><span class=\"name\">Book(II)</span></a>\n";

		if (not ($line =~ s/<div class="searchbox"/$extra<div class="searchbox"/)) {
			print STDERR "ERROR: Can't add extra buttons!";
			exit 1;
		}
		$didaddbuttons ++;
	}
	if ($line =~ m/<\/script><script.*mathjax\@4\/tex-mml-chtml/) {
		#avoid inline math wrapping, it does awful things
		print "window.MathJax = window.MathJax || {};\n";
  		print "window.MathJax.chtml = window.MathJax.chtml || {};\n";
  		print "window.MathJax.chtml.linebreaks = { inline: false };\n";
		$didmathjaxconfig ++;
	}
	if ($line =~ m/<\/head>/) {
		print "<style>\n";
		# Not really critical, avoids flashing some LaTeX code on initial load, as external .css files get loaded slowly
		print " .hidden-content { display:none; }\n";
		# This is for the print PDF warning below
		print " .print-pdf-warning { display:none; }\n";
		print " \@media print { .print-pdf-warning { display:inline; } }\n";
		print "</style>\n";
		$didheadstyleadd ++;
	}
	if ($line =~ m/<\/body>/) {
		print "<span class=\"print-pdf-warning\">\n";
		print " <em>For a higher quality printout use the PDF versions: ";
		print "<tt>https://www.jirka.org/ra/realanal.pdf</tt>,";
		print "<tt>https://www.jirka.org/ra/realanal2.pdf</tt></em>\n";
		print "or <tt>https://jirilebl.github.io/ra/realanal.pdf</tt>,";
		print "<tt>https://jirilebl.github.io/ra/realanal2.pdf</tt></em>\n";
		print "</span>\n";
		$didprintwarn ++;
	}
	# no longer there
	#$line =~ s/>Authored in PreTeXt</>Created with PreTeXt</;
	
	# In case chtml is broken again
	# Possibly not correct with move to mathjax 4, so fix before using
	#$line =~ s/^  ["]?chtml["]?: {/  "svg": {/;
	#$line =~ s/tex-chtml[.]js/tex-svg.js/;

	# and upgrade to mathjax4 and use pagella font?
	#$line =~ s/^  ["]?chtml["]?: {/  "svg": {/;
	#$line =~ s/tex-chtml[.]js/tex-svg-nofont.js/;
	#$line =~ s{mathjax\@3/es5}{mathjax\@4};
	#$line =~ s/^window.MathJax = {/window.MathJax = {\n  output: {\n    font: 'mathjax-pagella'\n  },/;

	#print line
	print $line;
}

if (($isindex == 0 && $didaddbuttons != 1) ||
    $didmathjaxconfig != 1 ||
    $didheadstyleadd != 1 ||
    $didprintwarn != 1) {
    print STDERR "ERROR: did not add something!";
    exit 1;
}
