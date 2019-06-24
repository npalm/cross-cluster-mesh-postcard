source 00-common.sh

if [[ "$TERM" =~ screen* || -n "${TMUX+x}" ]]
then
    echo "don't run inside screen or tmux"
    exit 1
fi

declare -r session_name="$C"

tmux new-session -d -s "$session_name"


cat clusters.csv | while read line
do


    declare window_name="$(echo $line | cut -d',' -f1)"

    tmux new-window -n "$window_name"
    tmux send-keys -t "${session_name}:${window_name}" "export KUBECONFIG=kubeconfig-$(echo $line | cut -d',' -f1)" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export CLUSTER_NAME=$(echo $line | cut -d',' -f1)" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export CLUSTER_REGION=$(echo $line | cut -d',' -f2)" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" Enter


done


for z in zone-*
do
    declare window_name="$(cat $z)"

    tmux new-window -n "$window_name"
    tmux send-keys -t "${session_name}:${window_name}" "export Z=$(cat $z)" Enter
    tmux send-keys -t "${session_name}:${window_name}" "export KUBECONFIG=kubeconfig-$(cat $z)" Enter
done

tmux attach -t "$session_name"
