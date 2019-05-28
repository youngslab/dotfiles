
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

alias vi='misc_run_bg_job_if_exist vim'
