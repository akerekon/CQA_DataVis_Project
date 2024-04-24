#!/bin/bash
filename="$1"

inkscape --export-png=${filename%.*}_auxfile.png ${filename%.*}.svg 
inkscape --export-pdf=${filename%.*}_auxfileVCT.pdf ${filename%.*}.svg
tesseract ${filename%.*}_auxfile.png ${filename%.*}_auxfileTXT -l eng pdf
./pdf-merge-text.sh ${filename%.*}_auxfileTXT.pdf ${filename%.*}_auxfileVCT.pdf ${filename%.*}_intermediate.pdf

rm -f ${filename%.*}_auxfile.png ${filename%.*}_auxfileVCT.pdf ${filename%.*}_auxfileTXT.pdf
