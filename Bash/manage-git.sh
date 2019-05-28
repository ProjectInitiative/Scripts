#!/bin/bash

function readValsFromJson {  
  # UNAMESTR=`uname`
  # if [[ "$UNAMESTR" == 'Linux' ]]; then
  #   SED_EXTENDED='-r'
  # elif [[ "$UNAMESTR" == 'Darwin' ]]; then
  #   SED_EXTENDED='-E'
  # fi; 

  # VALUE=`grep -m 1 "\"${2}\"" ${1} | sed ${SED_EXTENDED} 's/^ *//;s/.*: *"//;s/",?//'`

  local VALUES;
  VALUES=$(echo ${1} | grep -o -P "\"${2}\": \"\K([^\"]*)(?=\",)" -);


  if [ ! "$VALUES" ]; then
    echo "Error: Cannot find \"${2}\" in ${1}" >&2;
    exit 1;
  else
    echo $VALUES;
  fi; 
}

function getJson {
JSON=$(curl -s --request GET \
  --url https://api.github.com/user/repos \
  --header 'Accept: */*' \
  --header 'Authorization: Bearer  ACCESSTOKENHERE' \
  --header 'Cache-Control: no-cache' \
  --header 'Connection: keep-alive' \
  --header 'Host: api.github.com');
  echo "$JSON"
}
while getopts "kp" OPTION
do
	case $OPTION in
		k)
      JSON="$(getJson)"
      ssh_url_arr=($(readValsFromJson "$JSON" ssh_url));
      https_url_arr=($(readValsFromJson "$JSON" clone_url));
			for url in ${ssh_url_arr[@]}
        do 
          arr=($(echo "$url" | grep -Po '([^\/:])+'));
          repo=$(echo "${arr[-1]}" | sed 's/.git//');
          # Author is not formatted correctly
          author=${arr[-2]};

          echo $repo;
          echo $author;
          # echo;

          echo;
          echo "Cloning $url";
          git clone ${url} "./repos/${author}/${repo}";

        done
        # Make optional
        tar -czvf GITBACKUP.tar.gz ./repos;
        # Make optional
        rm -rf ./repos;
			exit
			;;
		p)
      JSON="$(getJson)";
      ssh_url_arr=($(readValsFromJson "$JSON" ssh_url));
      https_url_arr=($(readValsFromJson "$JSON" clone_url));
			# echo -n Username: 
      # read username
      # echo

      # echo -n Password: 
      # read -s password
      # echo

      token="ACCESSTOKENHERE";

      for url in ${https_url_arr[@]}
      do 
        arr=($(echo "$url" | grep -Po '([^\/])+'));
        repo=$(echo "${arr[-1]}" | sed 's/.git//');
        author=${arr[-2]};
        echo;
        # username=$(echo "$url" | grep -Po '\/([^\/]+)\/(.+)\.git')
        # repo=$(echo "$url" | grep -Po '([^\/]+$)')
        # echo $username
        # echo $repo
        echo "Cloning $url"
        # echo $repo
        # echo $author
        git clone "https://${token}@github.com/${author}/${repo}.git" "./repos/${author}/${repo}";
      done

      # Make optional
      tar -czvf GITBACKUP.tar.gz ./repos;
      # Make optional
      rm -rf ./repos;

			exit
			;;
		\?)
			echo "Used for the help menu";
			exit
			;;
	esac
done

# echo $(echo $JSON | grep -o -E "\"ssh_url\": \"([^\"]*)\"," -)
# echo $(echo $JSON | grep -o -P "\"ssh_url\": \"\K([^\"]*)(?=\",)" -)

# ssh_url_arr=($(readValsFromJson "$JSON" ssh_url));
# https_url_arr=($(readValsFromJson "$JSON" clone_url));

# for url in ${ssh_url_arr[@]}
# do 
#   # git clone $url;
#   echo "Cloning $url";
# done

# echo -n Username: 
# read username
# echo

# echo -n Password: 
# read -s password
# echo

# for url in ${https_url_arr[@]}
# do 
#   # git clone $url;
#   echo "Cloning $url"
#   git clone "$url";
# done
