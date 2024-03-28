#! /bin/bash

# match all logs between two timestamps. Quay timestamp format is always the same
grep -i "21:15:[45][0-9]" -r quay-enterprise-inspect* | grep nginx | grep -Po '\"\w+? \/.+?\/.* HTTP\/\d.\d\" \d{3}' | sort | uniq -c | grep PUT
