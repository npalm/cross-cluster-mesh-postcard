source 00-common.sh

set -x

eksctl create cluster \
    --name $CLUSTER_NAME \
    --region $CLUSTER_REGION \
    --version $K8S_VERSION \
    --nodegroup-name standard-workers \
    --node-type t3.medium \
    --nodes 1 \
    --nodes-min 1 \
    --nodes-max 4 \
    --node-ami auto \
    --kubeconfig=$KUBECONFIG \
    --tags "environment=mesh"
    

kubectl get nodes
