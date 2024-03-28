# list all HTTP requests in Quay log file
cat logfile | grep -Po '\"\w+? \/.+?\/.* HTTP\/\d.\d\" \d{3}' | sort | uniq -c

# List all exceptions raised in Quay log file
cat logfile | grep -Po '([A-za-z-]*) ([A-Za-z]*?) \| ([a-z]+)\.([A-Za-z\.]*)\:?(.*)?' | sort | uniq -c

# List all manifests and blobs that fail to be scanned in Clair log file
grep -i "\"level\":\"error\"" -rn clair-pod-logs | grep -i "failed to fetch layers" | sed -r  's/^.*(sha256:[0-9a-f]*).*(sha256:[a-f0-9]*).*$/manifest: \1 layer: \2/' | sort | uniq -c | sort -rn

# for blob in oc mirror log
for blob in $(cat .oc-mirror.log | grep EOF | grep blob | grep -Po "sha256:[a-f0-9]*" | cut -d':' -f2); do grep -i $blob -rn inspect.local.*; done | grep -Po '\"\w+? \/.+?\/.* HTTP\/\d.\d\" \d{3}' | sort | uniq -c | grep -E "(POST)|(PUT)|(PATCH)"

# match all logs between two timestamps. Quay timestamp format is always the same
grep -i "21:15:[45][0-9]" -r quay-enterprise-inspect* | grep nginx | grep -Po '\"\w+? \/.+?\/.* HTTP\/\d.\d\" \d{3}' | sort | uniq -c | grep PUT

# This one will count the number of requests made in Quay log files. Each request has the same format.
for uid in $(grep -Ei "(Starting request)|(Ending request)" -rn quay-registry-quay-app-df54fbc6b-* | grep -Ev "(internal_ping)|(health/instance)"| grep -Po "urn:[a-z0-9]*\:[a-f\-0-9]*" | sort | uniq -c | sort -nr | awk -F ' ' '$1 == "1"{print $2}' | xargs); do grep -i $uid -rn quay-registry-quay-app-df54fbc6b-* | grep -Po "quay-registry-quay-app-[a-z0-9]*-[a-z0-9]*"; done | sort | uniq -c | sort -nr
