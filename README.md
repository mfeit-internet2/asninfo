# ASNInfo Add-On for Splunk

This add-on does local lookups of issuing RIR, country and
organization for autonomous system numbers (ASNs) using data combined
from the RIRs and data made available to the public by MAXMIND.

The following commands are provided


| Command       | Input(s)  | Outputs       |
| ------------- | ----------|-------------- |
| asninfo       | asn       |rir country org|


## Installation

Your system must have the following installed prior to installing this
add-on:

 * Python version 2.6 or later.  (These programs should run under Python 3 as well but have not been tested.)

 * The Python API for SQLite3 and all of its prerequisites.  On Linux distributions derived from Red Hat, this is available in the EPEL repo as python-sqlite3.

## Setup

Copy the ASNInfo directory into `$SPLUNK_HOME/etc/apps`.

In the copy, change into the `data` directory and run `make clean
build`.  This will download the latest data and make it ready for use.
This process can be repeated to update the data.

Restart Splunk.


## Testing the programs

You can test that the plugin works by issuing the following commands:

  cd $SPLUNK_HOME/etc/apps/ASNInfo/bin
  $SPLUNK_HOME/bin/splunk cmd python asninfo < asninfo.csv

If it works, it should output something along these lines:

asn,nic,country,org
11164,arin,US,Internet2
701,arin,US,"MCI Communications Services, Inc. d/b/a Verizon Business"
1201,arin,US,Old Dominion University

You are now ready to start using the ASNInfo lookup commands!
  

## Example Searches

If you have logs with a single ASN field called `asn`:
```
* | lookup ga2 asn
```
