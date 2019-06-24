source 00-common.sh

set -x

INGRESS_HOST=$(kubectl -n istio-system \
get service istio-ingressgateway \
-o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

open http://$INGRESS_HOST/greeter
