#!/bin/bash

# First, preprocess the LaTeX to replace \cvsection with standard \section
sed 's/\\cvsection{\([^}]*\)}/\\section{\1}/g' main.tex > main_temp.tex

# Generate markdown from preprocessed LaTeX
pandoc main_temp.tex -o README.md --to=gfm --standalone

# Clean up
rm main_temp.tex

# Remove HTML comments and clean up formatting
sed -i '' '
# Remove HTML comments
/^<!-- -->$/d

# Clean up the center div
s/<div class="center">/<p align="center">/
s/<\/div>//
s/<div class="minipage">//
' README.md

echo "README.md updated"
