#!/bin/bash

usage() {
   echo  "./main.sh -d <domain_name> -w <word_list>"
   exit 1
}

while getopts ":d:w:" opt; do
    case ${opt} in
        d)
            dest_domain=$OPTARG
            ;;
        w)
            word_list=$OPTARG
            ;;
        \?)
            echo "Invalid parameter: $OPTARG" 1>&2
            usage
            ;;
        :)
            echo "You should enter parameters" 1>&2
            ;;
    esac
done

shift $((OPTIND -1))

if [[ -z $dest_domain ]] || [[ -z $word_list ]]; then
    echo "Destination domain and wordlist must be entered."
    usage
fi

while IFS= read -r subdomain; do
    http_status=$(curl -s -o /dev/null -w "%{http_code}" -L "$subdomain.$dest_domain")
    
    if [[ $http_status -eq 200 ]]; then
        echo "Found: $subdomain.$dest_domain"
    elif [[ $http_status -ge 300 && $http_status -lt 400 ]]; then
        redirected_url=$(curl -s -o /dev/null -w "%{redirect_url}" -L "$subdomain.$dest_domain")
        echo "Redirected: $subdomain.$dest_domain -> $redirected_url"
    fi
done < "$word_list"