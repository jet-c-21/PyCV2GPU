#!/bin/bash

COLOR_PINK='\e[1;38;5;206m'
COLOR_RED='\e[1;31m'
COLOR_GREEN='\e[1;32m'
COLOR_BLUE='\e[1;34m'
COLOR_YELLOW='\e[1;33m'
COLOR_MAGENTA='\e[1;35m'
COLOR_CYAN='\e[1;36m'
COLOR_C_RESET='\e[0m'

print() {
  echo -e "$1"
}

print_in_red() {
  echo -e "${COLOR_RED}$1${COLOR_C_RESET}"
}

print_in_green() {
  echo -e "${COLOR_GREEN}$1${COLOR_C_RESET}"
}

print_in_blue() {
  echo -e "${COLOR_BLUE}$1${COLOR_C_RESET}"
}

print_in_yellow() {
  echo -e "${COLOR_YELLOW}$1${COLOR_C_RESET}"
}

print_in_magenta() {
  echo -e "${COLOR_MAGENTA}$1${COLOR_C_RESET}"
}

print_in_cyan() {
  echo -e "${COLOR_CYAN}$1${COLOR_C_RESET}"
}

print_in_pink() {
  echo -e "${COLOR_PINK}$1${COLOR_C_RESET}"
}

print_in_red "this is red"
print_in_green "this is green"
print_in_blue "this is blue"
print_in_yellow "this is yellow"
print_in_magenta "this is magenta"
print_in_cyan "this is cyan"
print_in_pink "this is pink"
print "done"

