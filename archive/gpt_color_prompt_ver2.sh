#!/bin/bash

declare -A COLORS=(
  ["red"]='\e[1;31m'
  ["green"]='\e[1;32m'
  ["blue"]='\e[1;34m'
  ["yellow"]='\e[1;33m'
  ["magenta"]='\e[1;35m'
  ["cyan"]='\e[1;36m'
  ["pink"]='\e[1;38;5;206m'
  ["white"]='\e[1;37m'
)
COLOR_RESET='\e[0m'

print() {
  local text=$1
  if [ $# -eq 2 ]; then
    if [ $2 == "dflt" ]; then
        echo "${text}"
        return
    fi

    local color=${COLORS[$2]}
    echo -e "${color}${text}${COLOR_RESET}"

  elif [ $# -eq 1 ]; then
    local color=${COLORS["pink"]}
    echo -e "${color}${text}${COLOR_RESET}"
  fi
}

print "hi" red
print "done" green
print "this is blue" blue
print "this is yellow" yellow
print "this is magenta" magenta
print "this is cyan" cyan
print "this is pink" pink
print "lol"
print "lol" white
print "xxx" dflt
print "fwepfjwepfjwepfjpwe"