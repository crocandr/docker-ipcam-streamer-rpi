#!/bin/bash

[ ! -f /opt/streamer.sh ] &&  { echo "/opt/streamer.sh not found"; exit 1; }
bash /opt/streamer.sh 

# keep the container running
/bin/bash
