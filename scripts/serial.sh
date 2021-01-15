


# current pane id
tmux_curr_pane_id(){
  tmux display-message -p '#I.#P'
}

# server
# $1: token
dispatcher_set_server() {
  if [ $2 ]; then
    tmux setenv $1 $2
    return
  fi
  tmux setenv $1 $(tmux_curr_pane_id)
}

# $1: server, $2: command
dispatcher_send_to() {
  # TODO: check server exists
  tmux send-keys -t $(tmux showenv ${1} | sed "s:^.*=::") $2 Enter
}

dispatcher_usage(){
  echo "USAGE: Set up a server and send command to it."
	echo "       ex) dispatch_set_server XXX 1.3 (pane id is optional)"
  echo "           dispatch_send_to XXX ls"
}


SERIAL_SERVER_NAME="serial"

serial_send() {
  # send command to
  dispatcher_send_to ${SERIAL_SERVER_NAME} $1
}

# set connection
# ex) serial_set_conn [{winid}.{paneid}(optional)]
serial_set_server() {
  # set env variable to expose
  dispatcher_set_server ${SERIAL_SERVER_NAME} $1
}

# usage
serial_usage(){
  echo " USAGE: serial_set_conn {winid}.{paneid}(optional)"
  echo "        ex) serial_set_conn 1.1"
  echo "        ex) serial_set_conn"
}
