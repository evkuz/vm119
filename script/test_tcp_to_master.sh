#!/bin/bash
# just from command line
# </dev/tcp/10.93.221.8/8140 && echo Port open. || echo Port closed.


HOST=puppet-osg.jinr.ru
PORT=8140
#Bash handles several filenames specially when they are used in redirections, such as /dev/tcp/host/port.
# opens /dev/tcp/${HOST}/${PORT} for writing (">") on file descriptor 3. (0 - input, 1 - stdout, 2 - stderr)
# Все хорошо, но так мы зависнем на первом же хосте, гден нет соединения. Нужно вводить timeout ?
exec 3> /dev/tcp/${HOST}/${PORT}

# since the 'nc' command is interactive, so  pipe outputs (std and error) to nowhere
#nc -z ${HOST} ${PORT} >&2 >&1 > /dev/null

#</dev/tcp/10.93.221.8/8140 && echo $HOSTNAME Port open. || echo $HOSTNAME Port closed.
if [ $? -eq 0 ];then 
	echo "host ${HOST}, the port ${PORT} is open for host $HOSTNAME";
        echo "Hi ${HOST}" >3
   else 
	echo "the port ${PORT} is closed on host ${HOSTNAME}";
fi
