#!/bin/sh
T=`ps -eo pcpu | tail -n +2 | awk '{ SUM += $1} END {print int(SUM) }'`
if [ $T -gt $1 ]
then
    echo "Killing proc because top says " $T
    exit 1
else
    exit 0
fi