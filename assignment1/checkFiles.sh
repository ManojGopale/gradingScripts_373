#!/bin/bash
## Checking for bin in the directory
file=./bin
if [ -d bin -a -e reesult.txt ]; then
  echo "Directory bin exists in ${PWD}"
  ##\rm -rf bin/*
else
  echo "Directory does not exists in ${PWD}"
  ##mkdir bin
fi

