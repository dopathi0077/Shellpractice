#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "ERROR: Please run the script with root access"
   exit 1 # give other than 0 till 127
else
   echo "You are running with root access"
fi

dnf list installed nginx 
# check if nginx is already installed or not
# if not insatlled $? will be 1 then 1 -ne 0 will be executed it will install 
if [ $? -ne 0 ]
then 
  echo "installation is going to install now "
  dnf install nginx -y
  if [ $? -eq 0 ]
  then 
    echo "installation of nginx is ... SUCCESS"
  else
    echo "installation of nginx is ... FAILURE"
    exit 1
  fi
else
   echo "Nginx is already installed no changes to do !"
fi 
# dnf install nginx -y
# if [ $? -eq 0 ]
# then 
#   echo "installation of nginx is ... SUCCESS"
# else
#   echo "installation of nginx is ... FAILURE"
#   exit 1  
