# convert
#inkscape score_0.svg --export-area-drawing --export-pdf=score_0_area_drawing.pdf
# A4
#gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o score_0_area_drawing_A4.pdf score_0_area_drawing.pdf 

# RESULT - Bleeding Margins

# This works
#inkscape score_0.svg --export-area-page --export-pdf=score_0_area_page.pdf
# A4
# gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o output.pdf input.pdf
#gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o score_0_area_page_A4.pdf score_0_area_page.pdf 


#!/bin/bash

# Step 1: Convert SVGs to PDFs using Inkscape
inkscape score_0.svg --export-area-page --export-pdf=score_0_area_page.pdf
inkscape score_1.svg --export-area-page --export-pdf=score_1_area_page.pdf
inkscape score_2.svg --export-area-page --export-pdf=score_2_area_page.pdf
inkscape score_3.svg --export-area-page --export-pdf=score_3_area_page.pdf

# Step 2: Resize PDFs to A4 using Ghostscript
gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o score_0_area_page_A4.pdf score_0_area_page.pdf
gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o score_1_area_page_A4.pdf score_1_area_page.pdf
gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o score_2_area_page_A4.pdf score_2_area_page.pdf
gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o score_3_area_page_A4.pdf score_3_area_page.pdf

# Step 3: Merge the A4 PDFs into a single file
pdfunite score_0_area_page_A4.pdf score_1_area_page_A4.pdf score_2_area_page_A4.pdf score_3_area_page_A4.pdf combined_score_A4.pdf

# Step 4: Clean up temporary files
rm score_0_area_page.pdf score_1_area_page.pdf score_2_area_page.pdf score_3_area_page.pdf
rm score_0_area_page_A4.pdf score_1_area_page_A4.pdf score_2_area_page_A4.pdf score_3_area_page_A4.pdf

# Step 5: Open the final PDF
xdg-open combined_score_A4.pdf

#!/bin/bash

# Input SVG files
SVG_FILES=("score_0.svg" "score_1.svg" "score_2.svg" "score_3.svg")

# Temporary and output files
TMP_PDFS=()
OUTPUT_PDF="combined_score_A4_for_loop.pdf"

# Step 1: Convert SVGs to PDFs using Inkscape
for svg_file in "${SVG_FILES[@]}"; do
    pdf_file="${svg_file%.svg}_area_page.pdf"
    inkscape "$svg_file" --export-area-page --export-pdf="$pdf_file"
    TMP_PDFS+=("$pdf_file")
done

# Step 2: Resize PDFs to A4 using Ghostscript
for pdf_file in "${TMP_PDFS[@]}"; do
    a4_pdf_file="${pdf_file%.pdf}_A4.pdf"
    gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o "$a4_pdf_file" "$pdf_file"
    TMP_PDFS=("${TMP_PDFS[@]/$pdf_file/$a4_pdf_file}") # Update the list with A4 PDFs
done

# Step 3: Merge the A4 PDFs into a single file
pdfunite "${TMP_PDFS[@]}" "$OUTPUT_PDF"

# Step 4: Clean up temporary files
rm "${TMP_PDFS[@]}" "${SVG_FILES[@]/%.svg/_area_page.pdf}"

# Step 5: Open the final PDF
xdg-open "$OUTPUT_PDF"
