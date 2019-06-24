source 00-common.sh

set -x

kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/namespace.yaml

kubectl create secret generic -n istio-system cacerts \
    --from-file=istio-$ISTIO_VERSION/samples/certs/ca-cert.pem \
    --from-file=istio-$ISTIO_VERSION/samples/certs/ca-key.pem \
    --from-file=istio-$ISTIO_VERSION/samples/certs/root-cert.pem \
    --from-file=istio-$ISTIO_VERSION/samples/certs/cert-chain.pem
