# NetMonInfo
author: bootloops - made as part of admintools for network monitoring

## Clone repo, then:
if not already set,
>  chmod 755 infosec; chmod 755 auto_infosec;

## Usage:
run as admin, if you want access to root running connections.
> cd NetMonInfo
> ./auto_infosec 
	or
> ./infosec [runs once]

### Note: auto_infosec is just sleep script which will re-run infosec.
effectively updating the current network connection states.
this script will use curl to connect to ipinfo.io to grab some
info about connected ip's.