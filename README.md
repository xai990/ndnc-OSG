# ndnc-OSG
This repository contains the code for building a ndnc on [OSG](https://portal.osg-htc.org/) 

## Install ndnc and build the face with global ndn-dpdk testbed 

ndnc is the NDN consumer from [origin](https://github.com/sankalpatimilsina12/fabric-scripts) <br />
`ndnc.sh` is the bash script for installing ndnc. <br />
`ndnc.sub` is the script for submitting OSPool Jobs that allows to run multiple jobs at the same time. 

```bash
# submit the jobs to HTCondor's queue using condor_submit
condor_submit ndnc-ospool.sub

# to check on the status of the jobs in the queue
condor_q
```


## Output and debug 
There are three specific files under [results](https://github.com/xai990/ndnc-OSG/tree/main/results) folder. They are used to store the execution results and erro information from OSPool. <br />
`ndnc-ospool_(cluster)_(process).err`, this file contains the error information while the jobs running on ospool.<br />
`ndnc-ospool_(cluster)_(process).log`, this is the log file. <br />
`ndnc-ospool_(cluster)_(process).out`, this is the execution results while the jobs finish.  

## current issues

```
tee: /etc/apt/sources.list.d/nfd-nightly.list: No such file or directory
/srv//ndnc.sh: line 12: sudo: command not found
/srv//ndnc.sh: line 13: sudo: command not found
gpg: can't create `/usr/share/keyrings/docker-archive-keyring.gpg': No such file or directory
gpg: no valid OpenPGP data found.
gpg: dearmoring failed: No such file or directory
(23) Failed writing body
tee: /etc/apt/sources.list.d/docker.list: No such file or directory
/srv//ndnc.sh: line 17: sudo: command not found
/srv//ndnc.sh: line 18: sudo: command not found
/srv//ndnc.sh: line 19: sudo: command not found
newgrp: group 'docker' does not exist
/srv//ndnc.sh: line 21: docker: command not found
tee: /etc/docker/daemon.json: No such file or directory
jq: error: syntax error, unexpected '{' (Unix shell quoting issues?) at <top-level>, line 1:
{{ 
jq: error: May need parentheses around object key expression at <top-level>, line 1:
{{ 
jq: error: syntax error, unexpected '{' (Unix shell quoting issues?) at <top-level>, line 4:
  "log-opts": {{               
jq: error: May need parentheses around object key expression at <top-level>, line 4:
  "log-opts": {{               
jq: error: syntax error, unexpected ':', expecting $end (Unix shell quoting issues?) at <top-level>, line 8:
  "mtu": 1420,       
jq: 5 compile errors
/srv//ndnc.sh: line 33: sudo: command not found
--2023-07-31 08:49:03--  https://raw.githubusercontent.com/DPDK/dpdk/main/usertools/dpdk-hugepages.py
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.109.133, 185.199.110.133, 185.199.111.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.109.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 9066 (8.9K) [text/plain]
Saving to: 'dpdk-hugepages.py'

     0K ........                                              100% 26.9M=0s

2023-07-31 08:49:08 (26.9 MB/s) - 'dpdk-hugepages.py' saved [9066/9066]

/srv//ndnc.sh: line 36: sudo: command not found
/srv//ndnc.sh: line 40: docker: command not found
/srv//ndnc.sh: line 41: docker: command not found
/srv//ndnc.sh: line 42: docker: command not found
/srv//ndnc.sh: line 45: FW_ACTIVATE: command not found
/srv//ndnc.sh: line 46: mempool:: command not found
/srv//ndnc.sh: line 47: DIRECT:: command not found
/srv//ndnc.sh: line 48: INDIRECT:: command not found
/srv//ndnc.sh: line 49: },: command not found
/srv//ndnc.sh: line 50: syntax error near unexpected token `}'
/srv//ndnc.sh: line 50: `}'
```
