#! /bin/bash

# for blob in oc mirror log
for blob in $(cat .oc-mirror.log | grep EOF | grep blob | grep -Po "sha256:[a-f0-9]*" | cut -d':' -f2); do grep -i $blob -rn inspect.local.*; done | grep -Po '\"\w+? \/.+?\/.* HTTP\/\d.\d\" \d{3}' | sort | uniq -c | grep -E "(POST)|(PUT)|(PATCH)"
