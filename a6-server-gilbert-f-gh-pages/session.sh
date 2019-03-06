#!/bin/bash
# --------------------------------------------------------------------------------
# document here the main bash commands you are using for the server access.  The file contains
# two parts: the first one for the commands you run on your laptop, and the second one for the
# commands on the remote server.
# The question lists give your some guidance what to do and report but you are free to do it
# in a different order.  If you use a graphical frontend instead of scp for copying files,
# just say that in the appropriate place.
#
# -------------------- local commands --------------------
# 1. create a directory for this project.
mkdir img

# 2. log onto the server
ssh gilbertf@info201.ischool.uw.edu

# 3. copy the small data subset from the server to your local machine
scp gilbertf@info201.ischool.uw.edu:/opt/data/temp_prec_subset.csv.bz2 Desktop/'INFO 201'/a6-server-gilbert-f

# 4. copy your R-script to the server
scp Desktop/'INFO 201'/a6-server-gilbert-f/maps.R gilbertf@info201.ischool.uw.edu:a6/.

# 5. (after succesfully running the script remotely): copy the output files back to your computer
scp gilbertf@info201.ischool.uw.edu:a6/*.jpg Desktop/'INFO 201'/a6-server-gilbert-f/img

# 6. inspect that the copy was successful
just run/open and check the appropriate files

# -------------------- remote commands --------------------
# 1. explore the data directory '/opt/data'
cd /opt/data
ls

# 2. explore the first few lines of the small sample data
bzcat temp_prec_subset.csv.bz2 | head -4

# 3. create a directory for this project
mkdir a6

# 4. (after copying your code from the laptop): inspect the files in the project directory
just run/open and check the appropriate files

# 5. run your script
Rscript a6/maps.R

# 6. How do you install missing R packages?
1) open R in bash using the command, R
2) call the function, install.packages('[package_name]')

# 7. (after running the script): inspect the folder for output files
just run/open and check the appropriate files
