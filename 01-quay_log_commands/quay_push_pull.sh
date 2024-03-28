#! /bin/bash

# This one will count the number of requests made in Quay log files. Each request has the same format.
for uid in $(grep -Ei "(Starting request)|(Ending request)" -rn quay-registry-quay-app-df54fbc6b-* | grep -Ev "(internal_ping)|(health/instance)"| grep -Po "urn:[a-z0-9]*\:[a-f\-0-9]*" | sort | uniq -c | sort -nr | awk -F ' ' '$1 == "1"{print $2}' | xargs); do grep -i $uid -rn quay-registry-quay-app-df54fbc6b-* | grep -Po "quay-registry-quay-app-[a-z0-9]*-[a-z0-9]*"; done | sort | uniq -c | sort -nr
