#!/bin/bash

# make the remote repository
mkdir remote;
cd remote;
git init --initial-branch=main &> /dev/null;

# make commits "D", "E" on main branch
echo "D" >> file.txt; git add file.txt; git commit -m "D";
echo "E" >> file.txt; git add file.txt; git commit -m "E";

# create a new branch "topic-1". 
git branch topic-1;
# topic-1 now has commits "D" and "E" but our head is on main

# make commits "F", "G" on main branch
echo "F" >> file.txt; git add file.txt; git commit -m "F";
echo "G" >> file.txt; git add file.txt; git commit -m "G";
# topic-1 does not contain commits "F", "G"

# checkout topic-1. 
git checkout topic-1;
# head is now on topic-1

# make commits "A", "B", "C" on topic-1
echo "A" >> file.txt; git add file.txt; git commit -m "A";
echo "B" >> file.txt; git add file.txt; git commit -m "B";
echo "C" >> file.txt; git add file.txt; git commit -m "C";
# topic-1 now has commits D -> E -> A -> B -> C


# create new branch topic-2 from topic-1. 
git branch topic-2;
# topic-2 now has commits D -> E -> A -> B -> C
git checkout topic-2;
# head is now on topic-2

# make commits "L", "M", "N" on topic-2
echo "L" >> file.txt; git add file.txt; git commit -m "L";
echo "M" >> file.txt; git add file.txt; git commit -m "M";
echo "N" >> file.txt; git add file.txt; git commit -m "N";
# topic-2 now has commits D -> E -> A -> B -> C -> L -> M -> N

# checkout main branch
git checkout main;
# head is now on main

cd ..;

# clone remote repo into local
git clone remote local;

cd local;

git branch --track topic-1 origin/topic-1;
git branch --track topic-2 origin/topic-2;
git branch -lva;
git status;

