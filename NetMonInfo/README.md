# NetMonInfo
author: bootloops - made as part of admintools for network monitoring

## Clone repo, then:
if not already set,
>  chmod 755 infosec; chmod 755 auto_infosec;

## Usage:
run as admin, if you want access to root running connections.
using ./infosec will run once and will output an .html file.
open the .html file with your browser to view data.

Using ./auto_infosec will continuously update the .html file with connections
listed with netstat

>cd NetMonInfo
> ./auto_infosec 
	or
> ./infosec [runs once]

### *Note: auto_infosec is just sleep script which will re-run infosec.
effectively updating the current network connection states.
this script will use curl to connect to ipinfo.io to grab some
info about connected ip's.
