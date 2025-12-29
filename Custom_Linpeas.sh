#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

OUTPUT_FILE="linpeas_report_$(date +%Y%m%d_%H%M%S).txt"
SCAN_DELAY=0.5

print_separator() {
    echo -e "\n${BLUE}===============================================================================${NC}"
    echo -e "${BLUE}» $1${NC}"
    echo -e "${BLUE}===============================================================================${NC}\n"
}

check_system_info() { print_separator "SYSTEM INFORMATION"; hostname; uname -a; sleep $SCAN_DELAY; }
check_user_info() { print_separator "USER INFORMATION"; id; whoami; sleep $SCAN_DELAY; }
check_processes() { print_separator "PROCESS INFORMATION"; ps aux --sort=-%mem | head -10; sleep $SCAN_DELAY; }
check_network() { print_separator "NETWORK INFORMATION"; ip addr show || ifconfig; sleep $SCAN_DELAY; }
check_services() { print_separator "SERVICES"; systemctl list-units --type=service --state=running | head -10; sleep $SCAN_DELAY; }
check_cron() { print_separator "CRON JOBS"; ls -la /etc/cron* 2>/dev/null; sleep $SCAN_DELAY; }
check_files() { print_separator "INTERESTING FILES"; find / -type f -perm -o+w ! -path "/proc/*" 2>/dev/null | head -10; sleep $SCAN_DELAY; }
check_sudo() { print_separator "SUDO PERMISSIONS"; sudo -l 2>/dev/null; sleep $SCAN_DELAY; }
check_suid() { print_separator "SUID BINARIES"; find / -type f -perm -u=s 2>/dev/null | head -10; sleep $SCAN_DELAY; }
check_capabilities() { print_separator "LINUX CAPABILITIES"; getcap -r / 2>/dev/null | head -10; sleep $SCAN_DELAY; }
check_passwords() { print_separator "PASSWORD FILES"; find /home -name "*pass*" 2>/dev/null; sleep $SCAN_DELAY; }
check_login() { print_separator "LOGIN INFORMATION"; last -n 5; sleep $SCAN_DELAY; }
check_shells() { print_separator "AVAILABLE SHELLS"; cat /etc/shells; sleep $SCAN_DELAY; }
check_mounts() { print_separator "MOUNT INFORMATION"; mount | head -10; sleep $SCAN_DELAY; }
check_devices() { print_separator "DEVICE INFORMATION"; lsblk; sleep $SCAN_DELAY; }
check_kernel() { print_separator "KERNEL INFORMATION"; uname -r; sleep $SCAN_DELAY; }
check_environment() { print_separator "ENVIRONMENT VARIABLES"; env | head -10; sleep $SCAN_DELAY; }
check_history() { print_separator "COMMAND HISTORY"; tail -10 ~/.bash_history 2>/dev/null; sleep $SCAN_DELAY; }
check_packages() { print_separator "PACKAGE INFORMATION"; dpkg -l | head -10; sleep $SCAN_DELAY; }
check_logs() { print_separator "LOG FILES"; ls -la /var/log | head -10; sleep $SCAN_DELAY; }
check_containers() { print_separator "CONTAINER INFORMATION"; docker ps -a 2>/dev/null; sleep $SCAN_DELAY; }
check_web() { print_separator "WEB SERVER INFORMATION"; ss -tulpn | grep LISTEN; sleep $SCAN_DELAY; }
check_backups() { print_separator "BACKUP FILES"; find / -name "*.bak" 2>/dev/null | head -10; sleep $SCAN_DELAY; }
check_compilers() { print_separator "COMPILER AVAILABILITY"; which gcc python 2>/dev/null; sleep $SCAN_DELAY; }

 " [x] 1. System Info... "
INNER_WIDTH=40 

COL_H_BAR=$(printf '═%.0s' $(seq 1 $((INNER_WIDTH + 2)) ))

FULL_WIDTH=$(( 1 + INNER_WIDTH + 2 + 1 + INNER_WIDTH + 2 + 1 ))
FULL_H_BAR=$(printf '═%.0s' $(seq 1 $((FULL_WIDTH - 2)) ))

TBL_TOP_SOLID="╔${FULL_H_BAR}╗"

TBL_SPLIT="╠${COL_H_BAR}╦${COL_H_BAR}╣"

TBL_BOT="╚${COL_H_BAR}╩${COL_H_BAR}╝"

HDR_TOP="╔${FULL_H_BAR}╗"
HDR_BOT="╚${FULL_H_BAR}╝"

print_centered() {
    local text="$1"
    local text_len=${#text}
    local available=$((FULL_WIDTH - 2))
    local pad_l=$(( (available - text_len) / 2 ))
    local pad_r=$(( available - text_len - pad_l ))
    echo -e "${CYAN}║$(printf ' %.0s' $(seq 1 $pad_l))${text}$(printf ' %.0s' $(seq 1 $pad_r))║${NC}"
}

show_menu() {
    clear
    echo -e "${CYAN}${HDR_TOP}${NC}"
    print_centered ""
    print_centered "    ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗    "
    print_centered "   ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║    "
    print_centered "   ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║    "
    print_centered "   ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║    "
    print_centered "   ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║    "
    print_centered "    ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝    "
    print_centered ""
    print_centered "    ██╗     ██╗███╗   ██╗██████╗ ███████╗ █████╗ ███████╗    "
    print_centered "    ██║     ██║████╗  ██║██╔══██╗██╔════╝██╔══██╗██╔════╝    "
    print_centered "    ██║     ██║██╔██╗ ██║██████╔╝█████╗  ███████║███████╗    "
    print_centered "    ██║     ██║██║╚██╗██║██╔═══╝ ██╔══╝  ██╔══██║╚════██║    "
    print_centered "    ███████╗██║██║ ╚████║██║     ███████╗██║  ██║███████║    "
    print_centered "    ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝    "
    print_centered ""
    print_centered "By AKhilBangaru"
    echo -e "${CYAN}${HDR_BOT}${NC}"

    echo -e "${CYAN}${TBL_TOP_SOLID}${NC}"
    
    print_centered "Select checks to run (1-24)"
    
    echo -e "${CYAN}${TBL_SPLIT}${NC}"

    for i in {1..12}; do
        j=$((i+12))
        cv1="CHECK$i"; cv2="CHECK$j"

        if [[ "${!cv1}" == "✓" ]]; then sym1="[x]"; col_sym1="${GREEN}[x]${NC}"; else sym1="[ ]"; col_sym1="${CYAN}[ ]${NC}"; fi
        
        if [[ "${!cv2}" == "✓" ]]; then sym2="[x]"; col_sym2="${GREEN}[x]${NC}"; else sym2="[ ]"; col_sym2="${CYAN}[ ]${NC}"; fi

        case $i in 1) n1="System Information" ;; 2) n1="User Information" ;; 3) n1="Process Information" ;; 4) n1="Network Information" ;; 5) n1="Services" ;; 6) n1="Cron Jobs" ;; 7) n1="Interesting Files" ;; 8) n1="Sudo Permissions" ;; 9) n1="SUID Binaries" ;; 10) n1="Linux Capabilities" ;; 11) n1="Password Files" ;; 12) n1="Login Information" ;; esac
        case $j in 13) n2="Available Shells" ;; 14) n2="Mount Information" ;; 15) n2="Device Information" ;; 16) n2="Kernel Information" ;; 17) n2="Environment Variables" ;; 18) n2="Command History" ;; 19) n2="Package Information" ;; 20) n2="Log Files" ;; 21) n2="Container Info" ;; 22) n2="Web Server Info" ;; 23) n2="Backup Files" ;; 24) n2="Compiler Availability" ;; esac

        # Format Text: " 1. Name"
        printf -v text1 " %2d. %s" "$i" "$n1"
        printf -v text2 " %2d. %s" "$j" "$n2"

        pad1=$(( INNER_WIDTH - 3 - ${#text1} ))
        pad2=$(( INNER_WIDTH - 3 - ${#text2} ))
        
        [[ $pad1 -lt 0 ]] && pad1=0
        [[ $pad2 -lt 0 ]] && pad2=0

        spaces1=$(printf "%*s" $pad1 "")
        spaces2=$(printf "%*s" $pad2 "")

        echo -e "${CYAN}║${NC} ${col_sym1}${text1}${spaces1} ${CYAN}║${NC} ${col_sym2}${text2}${spaces2} ${CYAN}║${NC}"
    done

    echo -e "${CYAN}${TBL_BOT}${NC}"
    
    printf "${MAGENTA} Selected:%2d/24 ${NC}" "$selected_count"
    if [ "$selected_count" -gt 0 ]; then
        printf "${YELLOW}  ETA: ~%-2ds ${GREEN} File: %-25s${NC}\n" "$((selected_count * 2))" "$OUTPUT_FILE"
    else
        echo ""
    fi
    echo -ne "${WHITE}➜ ${NC}"
}

for i in {1..24}; do eval "CHECK$i=\"◯\""; done; selected_count=0
declare -A check_functions=( [1]="check_system_info" [2]="check_user_info" [3]="check_processes" [4]="check_network" [5]="check_services" [6]="check_cron" [7]="check_files" [8]="check_sudo" [9]="check_suid" [10]="check_capabilities" [11]="check_passwords" [12]="check_login" [13]="check_shells" [14]="check_mounts" [15]="check_devices" [16]="check_kernel" [17]="check_environment" [18]="check_history" [19]="check_packages" [20]="check_logs" [21]="check_containers" [22]="check_web" [23]="check_backups" [24]="check_compilers" )

update_count() { selected_count=0; for i in {1..24}; do cv="CHECK$i"; [[ "${!cv}" == "✓" ]] && ((selected_count++)); done; }

while true; do
    show_menu
    read -r input
    case "${input,,}" in
        [1-9]|1[0-9]|2[0-4]) 
            cv="CHECK$input"
            [[ "${!cv}" == "◯" ]] && eval "$cv=\"✓\"" || eval "$cv=\"◯\""
            update_count 
            ;;
        a) for i in {1..24}; do eval "CHECK$i=\"✓\""; done; update_count ;;
        c) for i in {1..24}; do eval "CHECK$i=\"◯\""; done; selected_count=0 ;;
        q) exit 0 ;;
        s) 
           if [ "$selected_count" -eq 0 ]; then continue; fi
           exec 3>&1; exec > >(tee "$OUTPUT_FILE") 2>&1
           clear; echo -e "${YELLOW}SCAN STARTING...${NC}"
           for i in {1..24}; do cv="CHECK$i"; [[ "${!cv}" == "✓" ]] && ${check_functions[$i]}; done
           exec 1>&3; echo -e "\n${GREEN}DONE: $OUTPUT_FILE${NC}"; read -p "Enter to return..." 
           ;;
    esac
done
