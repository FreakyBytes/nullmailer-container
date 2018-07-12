#!/bin/sh

# find address of docker host and make it available as domain name
DOCKERHOST=$(ip route | grep default | cut -d' ' -f 3)
echo "Running on Dockerhost $DOCKERHOST"
echo $DOCKERHOST dockerhost >> /etc/hosts

# set config via env vars
if [ $NULLMAILER_DEFAULT_DOMAIN ]; then
    echo $NULLMAILER_DEFAULT_DOMAIN > /etc/mailname
fi

if [ $NULLMAILER_HELO ]; then
    echo $NULLMAILER_HELO > /etc/nullmailer/helohost
fi

if [ $NULLMAILER_PAUSETIME ]; then
    echo $NULLMAILER_PAUSETIME > /etc/nullmailer/pausetime
fi

if [ $NULLMAILER_REMOTE ]; then
    echo $NULLMAILER_REMOTE > /etc/nullmailer/remotes
else
    echo "$DOCKERHOST smtp --port 25" > /etc/nullmailer/remotes
fi

echo "----------------------------------------"
echo " Current Mail Remotes:"
cat /etc/nullmailer/remotes
echo "----------------------------------------"
echo 

# Run nullmailer
/usr/sbin/nullmailer-send



