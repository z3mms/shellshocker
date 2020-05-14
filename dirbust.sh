#!/bin/bash
# Usage: ./dirbust.sh [URL] [Path to Wordlist]

export http_proxy="";

green='\e[0;32m'
NC='\e[0m' # No Color

if curl -A "Mozilla/4.0" -k -s --head "$1/cgi-bin/" | head -n 1 | grep -E "HTTP/1.[01] 403|200" > /dev/null; then

	for I in `cat $2`; do

		url="$1/cgi-bin/$I.cgi";
		
		echo -ne "Dirbusting: $url\033[0K\r"; 

		if curl -A "Mozilla/4.0" -k -s --head $url | head -n 1 | grep "HTTP/1.[01] [235].." > /dev/null; then
  			echo -e "${green}[+] CGI Script Found: $url${NC}"; echo $url>>urllist.txt
		fi
	done

else echo "CGI-BIN directory not available"

fi
