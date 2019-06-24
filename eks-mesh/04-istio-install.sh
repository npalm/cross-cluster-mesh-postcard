source 00-common.sh

set -x

$HELM template istio-$ISTIO_VERSION/install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
set +x

declare crd_count
while true
do
    crd_count=$(echo $(kubectl get crds | grep 'istio.io' | wc -l))
    echo "CRDs: $crd_count"
    if [ $crd_count -eq 53 ]
    then
        echo "OK."
        break
    else
        echo "Waiting..."
    fi
    sleep 1
done

set -x

$HELM template \
    --name istio \
    --namespace istio-system \
    istio-$ISTIO_VERSION/install/kubernetes/helm/istio \
    --values istio-$ISTIO_VERSION/install/kubernetes/helm/istio/example-values/values-istio-multicluster-gateways.yaml \
    | kubectl apply -f -

kubectl label namespace default istio-injection=enabled
