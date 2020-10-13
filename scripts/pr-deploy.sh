#!/bin/bash
echo "$PWD"
# deployment logic goes here
sleep 10
# instead we randomly succeed or fail the deployment
exit $(( $RANDOM % 10 >= 5 ))
