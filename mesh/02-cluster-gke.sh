source 00-common.sh

set -x

gcloud container clusters create \
    --zone $Z \
    --machine-type n1-standard-4 \
    --num-nodes 1 --enable-autoscaling --min-nodes 1 --max-nodes 5 \
    --addons HttpLoadBalancing,HorizontalPodAutoscaling,KubernetesDashboard \
    --cluster-version ${K8S_VERSION} \
    $C-$Z

kubectl create clusterrolebinding mt-admin --user "$(gcloud config get-value core/account)" --clusterrole cluster-admin

kubectl get nodes
