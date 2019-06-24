[ "$0" != "$BASH_SOURCE" ] || { echo "Error: script must be sourced, not run"; exit 1; }

source 00-versions.sh

set -x
export CLUSTER2_GW_ADDR=$(kubectl --kubeconfig=istio3.config get svc --selector=app=istio-ingressgateway -n istio-system -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')
set +x
