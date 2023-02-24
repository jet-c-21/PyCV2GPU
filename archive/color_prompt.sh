COLOR_RED='\e[1;31m'
COLOR_GREEN='\e[1;32m' # set the color code for green
COLOR_RED='\e[1;31m'
COLOR_GREEN='\e[1;32m'
COLOR_BLUE='\e[1;34m'
COLOR_YELLOW='\e[1;33m'
COLOR_MAGENTA='\e[1;35m'
COLOR_C_CYAN='\e[1;36m'
COLOR_C_REST='\e[0m'

print_in_read() {
	echo -e "${COLOR_RED}$1{$COLOR_C_REST}"
}

print "hi"

#echo -e "${COLOR_RED}This is red text${COLOR_C_NC}"
#echo -e "lol"