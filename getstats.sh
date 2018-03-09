#!/bin/sh
VOLI="realanal.tex ch-vol1-intro.tex ch-real-nums.tex ch-seq-ser.tex ch-contfunc.tex ch-der.tex ch-riemann.tex ch-seq-funcs.tex ch-metric.tex"
VOLII="realanal2.tex ch-several-vars-ders.tex ch-one-dim-ints-sv.tex ch-multivar-int.tex ch-approximate.tex"

echo
echo Volume I
echo Chapters:"\t"`grep '^[\]chapter\**{' $VOLI | wc -l`
echo Sections:"\t"`grep '^[\]section\**{' $VOLI | wc -l`
echo Exercises:"\t"`grep '^[\]begin{exercise' $VOLI | wc -l`
echo Figures:"\t"`grep '^[\]begin{myfigureht' $VOLI | wc -l`

echo
echo Volume II 
echo Chapters:"\t"`grep '^[\]chapter\**{' $VOLII | wc -l`
echo Sections:"\t"`grep '^[\]section\**{' $VOLII | wc -l`
echo Exercises:"\t"`grep '^[\]begin{exercise' $VOLII | wc -l`
echo Figures:"\t"`grep '^[\]begin{myfigureht' $VOLII | wc -l`

echo
echo Both volumes
echo Chapters:"\t"`grep '^[\]chapter\**{' $VOLI $VOLII | wc -l`
echo Sections:"\t"`grep '^[\]section\**{' $VOLI $VOLII | wc -l`
echo Exercises:"\t"`grep '^[\]begin{exercise' $VOLI $VOLII | wc -l`
echo Figures:"\t"`grep '^[\]begin{myfigureht' $VOLI $VOLII | wc -l`

echo
