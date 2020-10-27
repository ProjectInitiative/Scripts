# Copyright Kyle Petryszak 2020
#!/usr/bin/env bash

show_help()
{
cat << EOF
Usage: Usage: rsync-retry [SOURCE] [DEST] [-t: specify time in seconds between retries]
Try to sync SOURCE to DEST and retry with partial rsync process.

    -h          display this help and exit
    -t TIMEOUT  specify time in seconds between retries

EOF
}


# POSIX variable
OPTIND=1 # Reset in case getopts has been used previously in the shell.

source=""
dest=""
timeout=60

# getopts string seperated by : allows for missing optional parameter parsing
while getopts "h?t:" opt; do
    case $opt in 
    h|\?)
        show_help
        exit 0;;
    t)
        timeout = $OPTARG;;
    :)
        printf "Missing option argument for -$OPTARG\n" >&2
        exit 1;;         
    *)
        printf "Unimplemented option: -$OPTARG\n" >&2 
        exit 1;;	
    esac
done

shift $((OPTIND-1)) # Discard the options and sentinel --

[ "${1:-}" = "--" ] && shift # Discard any additional - and -- left over components?

if [[ "$#" -ne 2 ]]; then
    echo "missing required parameters"
    show_help
    exit 1
fi

# loop through remaining arguments
for (( i=1; i < "$#"; i++ ));
do
    cur_path="path$i"

    # get fully qualified path of provided path
    eval "${cur_path}"="$( cd "$( dirname "${!i}" )"; pwd -P)/$( basename "${!i}" )"
    
    # echo "${!cur_path}"
    # check if path if valid
    [ ! -d "${!cur_path}" ] && echo "${!cur_path} is not a valid directory" && exit 1
done



while true
do
        rsync -avz --partial -P "$path1" "$path2"
        if [ "$?" = "0" ]; then
                echo "Sync completed"
                exit
        else
                echo "Rsync failure. Retrying in $timeout seconds..."
                sleep $timeout
        fi
done