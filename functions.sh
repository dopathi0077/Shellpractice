#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "ERROR: Please run the script with root access" 
   exit 1 # give other than 0 till 127
else
   echo "You are running with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
      echo "Installing $2 is .... Succesfull"
    else
      echo "Installing $2 is .... Failure"   
      exit 1
    fi
}

dnf list installed nginx 
if [ $? -ne 0 ]
then 
  echo "nginx is going to install now "
  dnf install nginx -y
  VALIDATE $? "nginx"
else
   echo "Nginx is already installed no changes to do !"
fi 

dnf list installed msql 
if [ $? -ne 0 ]
then 
  echo "MySQL is not installed... going to install it"
  dnf install mysql -y
  VALIDATE $? "msql"
else
   echo "msql is already installed no changes to do !"
fi 

# dnf list installed mysql
# if [ $? -ne 0 ]
# then
#     echo "MySQL is not installed... going to install it"
#     dnf install mysql -y
#     VALIDATE $? "MySQL"
# else
#     echo "MySQL is already installed...Nothing to do"
# fi