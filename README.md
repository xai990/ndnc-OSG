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


## Output and debug 
There are three specific files to store the execution results and erro information from OSPool. <br />
`
