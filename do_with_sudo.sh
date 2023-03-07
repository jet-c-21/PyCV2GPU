# help me to finish the script
# try to implement the use_sudo function
# it's a function wrapper that will exec the passed command with sudo
# it will use the global var sudo_pwd to exec the passed command with sudo

sudo_pwd=1130

use_sudo() {
:<<COMMENT
straight way:
  echo "$sudo_pwd" | sudo -S your command
example:
  echo "$sudo_pwd" | sudo -S apt-get update
COMMENT

  local cmd="echo ${sudo_pwd} | sudo -S "
  for param in "$@"; do
    cmd+="${param} "
  done
  eval "${cmd}"
}

use_sudo apt-get update
