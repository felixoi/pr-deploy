#!/bin/bash
for entry in "$PWD"/*
do
  echo "$entry"
done
# deployment logic goes here
sleep 10
# instead we randomly succeed or fail the deployment
exit $(( $RANDOM % 10 >= 5 ))
