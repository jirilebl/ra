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
		#
		# FIXME: fix tracking?

		#if ($track) {
		#	print "<a onclick=\"gtag('event','download',{'event_category': 'ra', 'event_action': 'Link', 'event_label': 'PTXhtml(top) home ra'});\"\n";
		#} else {
		#	print "<a ";
		#}
		$extra = "<a class=\"index-button button\" href=\"https://www.jirka.org/ra/\" title=\"Home\" alt=\"Book Home\"><span class=\"name\">Home</span></a>\n";

		#if ($track) {
		#	print "<a onclick=\"gtag('event','download',{'event_category': 'PDF', 'event_action': 'Download', 'event_label': 'PTXhtml(top) /ra/realanal.pdf'});\"\n";
		#} else {
		#	print "<a ";
		#}
		$extra .= "<a class=\"index-button button\" href=\"https://www.jirka.org/ra/realanal.pdf\" title=\"PDF\"><span class=\"name\">PDF(I)</span></a>\n";

		#if ($track) {
		#	print "<a onclick=\"gtag('event','download',{'event_category': 'PDF', 'event_action': 'Download', 'event_label': 'PTXhtml(top) /ra/realanal.pdf'});\"\n";
		#} else {
		#	print "<a ";
		#}
		$extra .= "<a class=\"index-button button\" href=\"https://www.jirka.org/ra/realanal2.pdf\" title=\"PDF\"><span class=\"name\">PDF(II)</span></a>\n";

		##FIXME: add paperback buttons
		#if ($track) {
		#	print "<a onclick=\"gtag('event','download',{'event_category': 'amazon', 'event_action': 'Link', 'event_label': 'PTXhtml(top) ra'});\"\n";
		#} else {
		#	print "<a ";
		#}
		$extra .= "<a class=\"index-button button\" href=\"https://www.amazon.com/dp/B0C9S99TKF\" title=\"Paperback\" alt=\"Buy Paperback\"><span class=\"name\">Book(I)</span></a>\n";

		#if ($track) {
		#	print "<a onclick=\"gtag('event','download',{'event_category': 'amazon', 'event_action': 'Link', 'event_label': 'PTXhtml(top) ra'});\"\n";
		#} else {
		#	print "<a ";
		#}
		$extra .= "<a class=\"index-button button\" href=\"https://www.amazon.com/dp/B0C9S7P6M8\" title=\"Paperback\" alt=\"Buy Paperback\"><span class=\"name\">Book(II)</span></a>\n";

		if (not ($line =~ s/<button id="user-preferences-button"/$extra<button id="user-preferences-button"/)) {
			print STDERR "Can't add extra buttons!";
			exit 1;
		}
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
	# no longer there
	#$line =~ s/>Authored in PreTeXt</>Created with PreTeXt</;
	
	# In case chtml is broken again
	$line =~ s/^  chtml: {/  svg: {/;
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
