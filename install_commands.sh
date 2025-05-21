#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "Please run the script with root access"
   exit 1 # give other than 0 till 127
else
   echo "You are running with root access"
fi

dnf install nginx -y
