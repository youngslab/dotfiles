
tmux_curr_window_idx(){
  tmux display-message -p '#I'
}

tmux_curr_pane_idx(){
  tmux display-message -p '#P'
}

# current pane id
tmux_curr_pane_id(){
  tmux display-message -p '#{pane_id}'
}

# current window id
tmux_curr_window_id(){
  tmux display-message -p '#{window_id}'
}

# take pane to the current window
# $1 : src pane_id. ex) %3
tmux_take_pane(){
  pane_id=$(tmux_curr_pane_id)
  tmux join-pane -s $1 -t $(tmux_curr_window_id) > /dev/null 2>&1
  tmux select-pane -t $pane_id
}

# server
# $1: servername
dispatcher_set_server() {
  server_name=$1
  pane_id=$2
  if [ -z $pane_id ]; then
    pane_id=$(tmux_curr_pane_id)
  fi
  tmux setenv $server_name $pane_id
}

dispatcher_get_pane_id(){
  server_name=$1
  tmux showenv $server_name 2>/dev/null | sed "s:^.*=::"
}

# $1: server name
dispatcher_take_server(){
  server_name=$1
  pane_id=$(dispatcher_get_pane_id $server_name)
  tmux_take_pane $pane_id
}


# $1: server, $2: command
dispatcher_send_to() {
  pane_id=$(dispatcher_get_pane_id $1)
  shift
  tmux send-keys -t $pane_id "$*" Enter
}


dispatcher_usage(){
  echo "USAGE: Set up a server and send command to it."
  echo "       ex) dispatch_set_server XXX 1.3 (pane id is optional)"
  echo "           dispatch_send_to XXX ls"
}


SERIAL_SERVER_NAME="serial"

serial_send() {
  # send command to
  dispatcher_send_to ${SERIAL_SERVER_NAME} "$@"
}

# set connection
# ex) serial_set_conn [{winid}.{paneid}(optional)]
serial_set_server() {
  # set env variable to expose
  dispatcher_set_server ${SERIAL_SERVER_NAME} "$@"
}

serial_show() {
  dispatcher_take_server ${SERIAL_SERVER_NAME}
}

serial_fast() {
  serial_send fast
}

serial_show_regulators(){
  serial_send \
    'cd /sys/class/regulator'

  serial_send \
    'echo "No Name min-voltage target-voltage max-voltage";i=3; while [ 1 ]; do \
    if [ $i -gt 43 ]; then break; fi; echo "$i: $(cat ./regulator.$i/name) $(cat \
    ./regulator.$i/min_microvolts) <- $(cat ./regulator.$i/microvolts) -> \
    $(cat ./regulator.$i/max_microvolts)"; i=$(($i+1)); done'
}

# usage
serial_usage(){
  echo " USAGE: serial_set_conn {winid}.{paneid}(optional)"
  echo "        ex) serial_set_conn 1.1"
  echo "        ex) serial_set_conn"
}
