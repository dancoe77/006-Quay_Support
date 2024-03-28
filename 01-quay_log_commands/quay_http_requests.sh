#! /bin/bash

# list all HTTP requests in Quay log file
cat logfile | grep -Po '\"\w+? \/.+?\/.* HTTP\/\d.\d\" \d{3}' | sort | uniq -c
