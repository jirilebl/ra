#!/bin/sh
# Used from run-all-xp.sh
# Times
#exec elaps --pdf -p amsmath -p amsfonts -p amssymb -p mathptmx -p helvet -p nicefrac --size 12 $1
# Palatino
# FIXME: what about the options?
exec elaps --pdf -p amsmath -p amsfonts -p amssymb -p newpxtext -p newpxmath -p nicefrac --size 12 $1
