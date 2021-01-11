
misc_find_job_id(){
  local _job_name=$1
  jobs | grep $_job_name | awk '{print $1}' | grep -Eo "[0-9]{1,2}" 
}

misc_run_bg_job_if_exist(){
  local _job_name=$1
  local _job_id=$(misc_find_job_id $_job_name) 

  if [[ ! -z $_job_id ]]; then
    fg %$_job_id
    return
  fi

  eval $@
}

misc_print_color(){
  for x in {0..8}; do
    for i in {30..37}; do
        for a in {40..47}; do
            echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
        done
        echo
    done
  done
  echo ""
}

