#!/bin/bash


# Script to configure your environment and pull ec2 data and run ansible 
ENVIRONMENT_DIR="environments"
ENVIR=`find $ENVIRONMENT_DIR -maxdepth 1 -type f |awk -F '/' '{print $NF}' `

help(){
    echo "$0 Help function:
    -e <environment> (NPE/PROD)
    -f <function> (cmsdeliveryapi)
    -g <group> (qastg/dev/demo/etc.)
    -m <module> Ansible Module
    -a <action> Ansible Action
    -u <user> Ansible User
    -h This help

    "
}

menu(){
    choice=1
    prompt=$1
    shift 1
    savevari=$1
    shift 1
    list=($*)
    length="${#list[@]}"
    echo "$length"
    echo ""
    for item in ${list[@]};
        do
            echo "$choice)  $item"
            choice=${choice+1}
    done
    read -p "$prompt " $savevari
    eval "temp=\${$savevari}"
    checkvalue "$temp" "$list"
    if [[ $? = 0 ]]
    then
        echo "Using $temp"
    else
        echo "Please enter valid option"
        menu "$prompt" "$savevari" "${#list[@]}"
    fi

    #read -p "Which Environment would you like to choose? " ENVIRONMENT
}

checkvalue(){
    chosen=$1
    shift 1
    list=$*
    if [[ $list =~ $chosen ]] #The list contains the chosen option
    then
        return 0
    else
        return 1
    fi
}

setenvir(){
#ENVIR=`find $ENVIRONMENT_DIR -maxdepth 1 -type f |awk -F '/' '{print $NF}' `
menu "Which Environment would you like to choose?" ENVIRONMENT $ENVIR
}


while getopts :e:c:f:g:m:a:u:h OPTS; do
    case $OPTS in 
        e) #Environment (NPE/PROD)
            ENVIRONMENT=$OPTARG
            ;;
        c) #Config
            echo "Config"
            ;;
        f) #Function tag
            FUNCTION=$OPTARG
            echo "-f used : $FUNCTION"
            ;;
        g) #Group (Dev/Demo/qastg/etc.)
            GROUP=$OPTARG
            echo "-g used : $GROUP"
            ;;
        m) #Ansible Module
            MODULE=$OPTARG
            echo "-m used : $MODULE"
            ;;
        a) #Ansible Action
            ACTION=$OPTARG
            echo "-a used : $ACTION"
            ;;
        u) #Ansible User
            USER=$OPTARG
            echo "-u used : $USER"
            ;;
        h) #Help
            help 
            ;;
        \?) #unrecognized option - show help
            echo "Unrecognized Option"
            help
            ;;
    esac
done

shift $((OPTIND-1))



if [[ -z "$ENVIRONMENT" ]]
then
    setenvir
else
    checkvalue $ENVIRONMENT $ENVIR
    if [[ $? = 0 ]]
    then
        echo "Using $ENVIRONMENT"
    else
        echo "Please enter valid option"
        menu "Which Environment would you like to choose?" ENVIRONMENT $ENVIR
    fi

fi

#ansible -i ec2.py "tag_Function_playersvcs:&tag_Environment_qastg" -m shell --sudo -k -a "/usr/local/bin/puppet agent -t" -u william_lamb
