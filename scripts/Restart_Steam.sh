#!/bin/bash
for i in $(ps -ef | grep steam | awk '{print $2}'); do kill -9 $i; done; millennium apply && .millennium/start.sh
# this currently doesn't work, millennium changed its CLI
