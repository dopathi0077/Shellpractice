#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "Please run the script with root access"
else
   echo "You are running with root access"
fi

dnf install nginx -y
