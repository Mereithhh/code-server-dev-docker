#!/bin/bash
while true; do 
    sleep 1
    if [ -f /boynextdoor ]; then
        break
    fi
done;