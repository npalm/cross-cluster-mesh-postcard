source 00-common.sh

set -x

cat 08x-messenger-service-entry.yaml | sed "s/CLUSTER2_GW_ADDR/${CLUSTER2_GW_ADDR}/" | kubectl apply -f  -
