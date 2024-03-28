#! /bin/bash

# List all exceptions raised in Quay log file
cat logfile | grep -Po '([A-za-z-]*) ([A-Za-z]*?) \| ([a-z]+)\.([A-Za-z\.]*)\:?(.*)?' | sort | uniq -c
