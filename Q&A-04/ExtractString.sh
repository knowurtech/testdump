#!/bin/bash

grep ACTIVE /tmp/test.txt | \
tr '[:lower:]' '[:upper:]' | \
awk '{print $NF}' | \
sed "s/'//g"
