# This script generates a tex script that can generate a pdf document.

# Import packages or modules.
import os

# Set parameters

# Output tex file name.
wd_path = 'docs'
# tex_file_name = 'docs/regression_paper.tex'
tex_file_name = 'regression_paper.tex'

# Move into working directory.
os.chdir(wd_path)


# Generate the tex file and build the pdf.
open_file = open(tex_file_name, 'w')

# Write the preamble.
open_file.write('\n\\documentclass{paper}\n')
open_file.write('\n\\begin{document}\n')


open_file.write('\n\nThank you for reading my regression paper.\n\n')

open_file.write('\nThis is my regression equation:\n')
open_file.write('\n\\begin{equation}\n%')
open_file.write('\n\tY = X\\beta + \\epsilon\n')
open_file.write('%\n\\end{equation}\n')





# Closing arguments.
open_file.write('\\end{document}')
open_file.close()

# Build the document.
os.system('pdflatex %s' % tex_file_name)



# End.
