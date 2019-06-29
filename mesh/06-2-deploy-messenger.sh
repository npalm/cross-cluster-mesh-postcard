source 00-common.sh

set -x
export MESSAGE=All good in cluster 2.
cat demo/messenger/messenger.yaml | sed "s/MESSAGE_TEXT/$MESSAGE/" | kubectl apply -f -
