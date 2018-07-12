nullmailer Docker
=================

This image contains nullmailer on Alpine Linux.
The compile and build instructions were taken from [vimagick/dockerfiles](https://github.com/vimagick/dockerfiles/tree/master/nullmailer)

Nullmailer is a sendmail/qmail/etc replacement MTA for hosts which
relay to a fixed set of smart relays.  It is designed to be simple to
configure, secure, and easily extendable.

## Use the image

This image can be simply configured using a few Environment variables

* `NULLMAILER_DEFAULT_DOMAIN`: Defines the default domain, i.e. the domain of the relay. Defaults to `localhost.lan`
* `NULLMAILER_HELO`: Changes the host to be send during the HELO command. Defaults to `NULLMAILER_DEFAULT_DOMAIN`
* `NULLMAILER_PAUSETIME`: Time in seconds to wait between send attempts. Defaults to `30`
* `NULLMAILER_REMOTE`: Remote Smart-MTAs. Defaults to the dockerhost with port 25.  
   cf. the [nullmailer-send.8](https://github.com/bruceg/nullmailer/blob/master/doc/nullmailer-send.8) for the format and further options

## Build the image

Simply run `docker build -t nullmailer .`
