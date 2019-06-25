source 00-common.sh

set -x

cat 10x-messenger-service-entry.yaml | sed "s/CLUSTER2_GW_ADDR/${CLUSTER2_GW_ADDR}/" | sed "s/CLUSTER3_GW_ADDR/${CLUSTER3_GW_ADDR}/" | kubectl apply -f  -
