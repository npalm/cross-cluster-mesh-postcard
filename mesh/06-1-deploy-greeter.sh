[ "$0" != "$BASH_SOURCE" ] || { echo "Error: script must be sourced, not run"; exit 1; }

source 00-versions.sh

set -x
cat demo/greeter/greeter.yaml | sed "s/CLUSTER_NAME/${CLUSTER_NAME}/" | kubectl apply -f -
kubectl apply -f demo/greeter/gateway.yaml

export GREETER_URL=$(kubectl -n istio-system \
    get service istio-ingressgateway \
    -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')/greeter
set +x
