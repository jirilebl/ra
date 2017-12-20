#!/bin/sh
# run all the .xp files into .pdf files
for n in *.xp ; do
	if ! ./run-xp-topdf.sh $n ; then
		echo
		echo '\033[0;31m'"ERROR! run-xp-topdf $n failed"'\033[0m'
		echo
		exit 1;
	fi
done
echo
echo '\033[0;32mSuccess!\033[0m'
echo
