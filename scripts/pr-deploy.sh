#!/bin/bash
echo ${$GITHUB_REF | cut -d '/' -f 3}

# instead we randomly succeed or fail the deployment
exit $(( $RANDOM % 10 >= 5 ))
