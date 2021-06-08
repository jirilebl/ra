#!/bin/zsh

echo OPTIMIZING SVG...
for n in *.svg ; do
  #echo svgo --disable=convertPathData --multipass $n
  #svgo --disable=convertPathData --multipass $n
  echo svgo --multipass $n
  svgo --multipass $n
done
