#!/bin/bash

################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Shell Script for Grading Assignment 2
#
# Lealand Morin, Ph.D.
# Assistant Professor
# College of Business
# University of Central Florida
#
# September 17, 2020
#
################################################################################
#
# This shell script clones repos, makes modifications,
# runs a script, then pushes changes for grading an assignment.
#
################################################################################



################################################################################
# Cloning repos
################################################################################

echo "Cloning git repos..."

# This declares an array of string urls for the loop:
declare -a REPO_URLS=("https://github.com/git-user-name-1/name-of-repo-1.git"
"https://github.com/git-user-name-2/name-of-repo-2.git"
"https://github.com/git-user-name-3/name-of-repo-3.git"
"https://github.com/git-user-name-4/name-of-repo-4.git")

for REPO in ${REPO_URLS[@]}
do
    # Append the current dataset to the full dataset.
    echo "Cloning repo from "$REPO""

    git clone "$REPO"


done




################################################################################
# Copying testing script.
################################################################################

echo "Copying scripts for Assignment 2..."


# This declares an array of paths to folders for the loop:
declare -a A2_FOLDERS=("name-of-repo-1/assignment_02/"
"git-user-name-2/assignment_02/"
"git-user-name-3/assignment_02/"
"git-user-name-4/assignment_02/")

for A2_FOLDER in ${A2_FOLDERS[@]}
do
    # Append the current dataset to the full dataset.
    echo "Copying files to "$A2_FOLDER""
    echo "Copying files to "$A2_FOLDER"" >> copy_test.out

    cp ../QMB6358F20/assignment_02/A2_test_soln.sh "$A2_FOLDER"
    cp ../QMB6358F20/assignment_02/A2Q1_functions_soln.R "$A2_FOLDER"
    cp ../QMB6358F20/assignment_02/A2Q2_testing_soln.R "$A2_FOLDER"

    ls "$A2_FOLDER" >> copy_test.out


done



################################################################################
# Pushing changes to repos
################################################################################

echo "Pushing changes for Assignment 2..."

# This declares an array of paths inside each repo for the loop:
declare -a REPO_NAMES==("name-of-repo-1"
"git-user-name-2"
"git-user-name-3"
"git-user-name-4")


# Initialize into one of the repos.
cd name-of-repo-1
for REPO_FOLDER in ${REPO_NAMES[@]}
do
    # Append the current dataset to the full dataset.
    echo "Pushing changes to "$REPO_FOLDER""

    cd ../"$REPO_FOLDER"
    git status
    git add .
    git commit -m "Solutions and sample scripts for Assignment 2"
    git push origin main



done


################################################################################
# end
################################################################################
