#!/bin/bash

# Install img2pdf if not already installed
if ! command -v img2pdf &> /dev/null; then
    echo "img2pdf is not installed. Installing it now..."
    sudo apt install img2pdf -y
fi

# Convert PNG files to PDF using img2pdf
for i in {1..4}; do
    img2pdf Purcell_$i.png -o Purcell_$i.pdf
done

# Combine PDFs into a single file
pdfunite Purcell_1.pdf Purcell_2.pdf Purcell_3.pdf Purcell_4.pdf combined.pdf

# Resize the combined PDF to A4 size using pdfjam
if ! command -v pdfjam &> /dev/null; then
    echo "pdfjam is not installed. Installing it now..."
    sudo apt install texlive-extra-utils -y
fi
pdfjam --paper a4paper --outfile final_a4.pdf combined.pdf

# Clean up intermediate files
rm Purcell_1.pdf Purcell_2.pdf Purcell_3.pdf Purcell_4.pdf combined.pdf

echo "Process completed. The final A4 PDF is saved as final_a4.pdf."
