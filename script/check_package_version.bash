#!/bin/bash
eval "$(dpkg -l | grep zlib1g | awk '/zlib1g/{print "version=" $3}')"

if [[ "$version" = "1:1.2.7.dfsg-13" ]]
        then
        echo "VERSION IS CORRECT !!"
        # Запускаем downgrade пакета
    else
	echo "WRONG VERSION !!!"

fi
