Cropped at https://smallpdf.com/

NB Needs to be set to A4 size - verify in the PDF properties. 

Two possibilities:

1. Print the document setting to A4

2. Command line with Ghost Script:

gs -sDEVICE=pdfwrite -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 -dAutoRotatePages=/None -o Sibelius_A4.pdf Sibelius-Sym2.Trumpet_ALL_Bb-cropped.pdf


