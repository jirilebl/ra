#!/usr/bin/perl

# This is hackish, but I can't figure out how to modify the html output otherwise

my ($arg) = @ARGV;

my $track = 0;

if (defined $arg && $arg eq "--track=yes") {
	$track = 1;
}

while($line = <STDIN>)
{
	if ($line =~ m/<a class="index-button.*index-1.html.*Index/) {
		# Add extra buttons

		if ($track) {
			print "<a onclick=\"gtag('event','download',{'event_category': 'ra', 'event_action': 'Link', 'event_label': 'PTXhtml(top) home ra'});\"\n";
		} else {
			print "<a ";
		}
		print " class=\"index-button toolbar-item button\" href=\"https://www.jirka.org/ra/\" title=\"Home\" alt=\"Book Home\">Home</a>\n";

		if ($track) {
			print "<a onclick=\"gtag('event','download',{'event_category': 'PDF', 'event_action': 'Download', 'event_label': 'PTXhtml(top) /ra/realanal.pdf'});\"\n";
		} else {
			print "<a ";
		}
		print " class=\"index-button toolbar-item button\" href=\"https://www.jirka.org/ra/realanal.pdf\" title=\"PDF\">PDF(I)</a>\n";

		if ($track) {
			print "<a onclick=\"gtag('event','download',{'event_category': 'PDF', 'event_action': 'Download', 'event_label': 'PTXhtml(top) /ra/realanal.pdf'});\"\n";
		} else {
			print "<a ";
		}
		print " class=\"index-button toolbar-item button\" href=\"https://www.jirka.org/ra/realanal2.pdf\" title=\"PDF\">PDF(II)</a>\n";

		##FIXME: add paperback buttons
		if ($track) {
			print "<a onclick=\"gtag('event','download',{'event_category': 'amazon', 'event_action': 'Link', 'event_label': 'PTXhtml(top) ra'});\"\n";
		} else {
			print "<a ";
		}
		print " class=\"index-button toolbar-item button\" href=\"https://smile.amazon.com/dp/1718862407\" title=\"Paperback\" alt=\"Buy Paperback\">Book(I)</a>\n";

		if ($track) {
			print "<a onclick=\"gtag('event','download',{'event_category': 'amazon', 'event_action': 'Link', 'event_label': 'PTXhtml(top) ra'});\"\n";
		} else {
			print "<a ";
		}
		print " class=\"index-button toolbar-item button\" href=\"https://smile.amazon.com/dp/1718865481\" title=\"Paperback\" alt=\"Buy Paperback\">Book(II)</a>\n";
	}
	if ($line =~ m/<\/head>/) {
		# Fast preview doesn't seem worth it and it could be confusing since it's not quite right so disable it
		# Note: Doesn't really work in MathJax3, but it's probably not needed anymore
		#print "<script type=\"text/x-mathjax-config\">\n";
		#print " MathJax.Hub.Config({\n";
		#print "  \"fast-preview\": {\n";
		#print "   disabled: true,\n";
		#print "  },\n";
		#print " });\n";
		#print "</script>\n";
		
		print "<style>\n";
		# Not really critical, avoids flashing some LaTeX code on initial load, as external .css files get loaded slowly
		print " .hidden-content { display:none; }\n";
		# This is for the print PDF warning below
		print " .print-pdf-warning { display:none; }\n";
		print " \@media print { .print-pdf-warning { display:inline; } }\n";
		print "</style>\n";
	}
	if ($line =~ m/<\/body>/) {
		print "<span class=\"print-pdf-warning\">\n";
		print " <em>For a higher quality printout use the PDF versions: <tt>https://www.jirka.org/ra/realanal.pdf</tt>";
		print " or <tt>https://www.jirka.org/ra/realanal2.pdf</tt></em>\n";
		print "</span>\n";
	}
	$line =~ s/>Authored in PreTeXt</>Created with PreTeXt</;
	$line =~ s/tex-chtml[.]js/tex-svg.js/;

	#print line
	print $line;

	#this goes after the line
	if ($track && $line =~ m/^<head>/) {
		print "<!-- Global site tag (gtag.js) - Google Analytics -->\n";
		print "<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-36064105-1\"></script>\n";
		print "<script>\n";
		print "window.dataLayer = window.dataLayer || [];\n";
		print "function gtag(){dataLayer.push(arguments);}\n";
		print "gtag('js', new Date());\n";
		print "gtag('config', 'UA-36064105-1');\n";
		print "</script>\n";
	}
}
