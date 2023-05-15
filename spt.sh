#!/bin/bash

msg="$1"  # Retrieve the message from the first command-line argument

# Perform git commands
git add .
git commit -m "$msg"
