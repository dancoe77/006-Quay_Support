#! /bin/bash

# List all manifests and blobs that fail to be scanned in Clair log file
grep -i "\"level\":\"error\"" -rn clair-pod-logs | grep -i "failed to fetch layers" | sed -r  's/^.*(sha256:[0-9a-f]*).*(sha256:[a-f0-9]*).*$/manifest: \1 layer: \2/' | sort | uniq -c | sort -rn
