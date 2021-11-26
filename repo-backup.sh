#!/usr/bin/bash

#    ____  ____        ____             __               _                   _
#   |  _ \/ ___|      |  _ \ _ __ ___  / _| ___  ___ ___(_) ___  _ __   __ _| |
#   | |_) \___ \ _____| |_) | '__/ _ \| |_ / _ \/ __/ __| |/ _ \| '_ \ / _` | |
#   |  __/ ___) |_____|  __/| | | (_) |  _|  __/\__ \__ \ | (_) | | | | (_| | |
#   |_|   |____/      |_|   |_|  \___/|_|  \___||___/___/_|\___/|_| |_|\__,_|_|
#

#Give input from user
function get_store_data(){
    read -p 'Please enter your GitHub username: ' user
    read -p 'Please enter your GitHub organization name: ' organization
    read -p 'Please enter your GitHub token : ' token
    GSstate=1
    while [[ $GSstate = 1 ]]
    do
        read -p 'Do you want store this information for future usage? ([Y]es, [N]o) ' store
        if [[ $store = 'yes' ]] || [[ $store = 'y' ]] || [[ $store = 'Y' ]]
		then
		    echo $user:$organization:$token > .profile_git ; sleep 1 ; GSstate=0
		elif [[ $store = 'no' ]] || [[ $store = 'n' ]] || [[ $store = 'N' ]]
		then
		    echo "OK!" ; sleep 1 ; GSstate=0			
		else
		  	echo "Operation not specified!" ; sleep 0.5
		  	echo "Please try again!" ; sleep 0.5
		fi
    done
}

function init(){
    if [[ -f .profile_git ]]
    then
        user=`cat .profile_git | cut -d ':' -f 1 `
        organization=`cat .profile_git | cut -d ':' -f 2 `
        token=`cat .profile_git | cut -d ':' -f 3 `
        echo "This is your stored information:" ; sleep 1
        echo User \: $user ; sleep 0.5
        echo Organization name \: $organization ; sleep 0.5
        echo GitHub access token \: $token ; sleep 2
        State=1
        while [[ $State = 1 ]]
        do 
            read -p 'Are these data true? ([Y]es, [N]o) ' data_verify
            if [[ $data_verify = 'yes' ]] || [[ $data_verify = 'y' ]] || [[ $data_verify = 'Y' ]]
            then
                echo "Got it!" ; sleep 1
                State=0
            elif [[ $data_verify = 'no' ]] || [[ $data_verify = 'n' ]] || [[ $data_verify = 'N' ]]
            then
                echo "Don't worry. We'll fix it! :)" ; rm .profile_git ; sleep 1
                get_store_data ; State=0
            else
                echo "Operation not specified!" ; sleep 0.5
                echo "Please try again!" ; sleep 0.5
            fi
        done
    else
        echo This script need your information to perform backup task ; sleep 1 
        get_store_data
    fi
}

#Give each repository and archive them
function file_perform(){
    for repo in `curl -s https://api.github.com/orgs/$organization/repos\?type\=private\&per_page\=100 -u ${user}:${token} | grep 'ssh_url' | sed -e 's/"//g' -e 's/ *//g' -e 's/,//' | cut -d ':' -f 2,3`
    do
        repo_name=$(echo $repo | cut -d '/' -f 2 | cut -d '.' -f 1)
        echo "Repository found: $repo_name ($repo)"
        git clone $repo
        echo archiving repository $repo_name...
        tar cJvf $repo_name.tar.xz $repo_name
        rm -rf $repo_name
        echo '======================================================'
        sleep 1
    done
}


#Main code
clear
sleep 1
echo "Welcome to Organization Backup scrpit!"
sleep 1
echo "Developed by PS-Professional"
sleep 1
echo "Let's start! :)"
init

mkdir tmp ; cd tmp ; pwd
file_perform
tar cJvf tmp * && mv tmp ../RepoBackup\(`date +"%d%b%Y"`\).tar.xz
rm -f * && cd .. && rm -rf tmp

echo "Final file created!"
sleep 1
echo "Have a nice day! :)"