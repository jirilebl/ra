#!/bin/sh
# Used from run-all-xp.sh
exec elaps --pdf -p amsmath -p amsfonts -p amssymb -p mathptmx -p helvet -p nicefrac --size 12 $1
