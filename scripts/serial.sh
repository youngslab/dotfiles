
# current pane id
tmux_curr_pane_id(){
  tmux display-message -p '#I.#P'
}

tmux_curr_win_id(){
  tmux display-message -p '#I'
}

tmux_pane_count(){
  tmux list-panes | wc -l
}

# $1 : src pane id. ex) 1.3
# return its new pane id
tmux_take_pane(){
	winid=$(tmux_curr_win_id)
	paneid=$(tmux_curr_pane_id)
	prev=$(tmux_pane_count)
  tmux join-pane -s $1 -t $winid > /dev/null 2>&1
	tmux select-pane -t $paneid > /dev/null 2>&1
	curr=$(tmux_pane_count)
	if [ $prev == $curr ]; then
		echo -1.-1
		return
	fi
	echo $winid.$curr
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

# $1: server name
dispatcher_take_server(){
  server=$(tmux showenv ${1} | sed "s:^.*=::")
	server=$(tmux_take_pane $server)
	echo dispatcher takes $server
	if [ server == "-1.-1" ]; then
		return
	fi

	tmux setenv $1 $server
}


# $1: server, $2: command
dispatcher_send_to() {
  # TODO: check server exists
  server=$(tmux showenv ${1} | sed "s:^.*=::")
  shift
  tmux send-keys -t $server "$*" Enter
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
