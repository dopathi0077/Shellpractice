#! /bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "ERROR: Please run the script with root access" 
   exit 1 # give other than 0 till 127
else
   echo "You are running with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ] # it will pass the exit status args VALIDATE $? "nginx" as $1 and $2 to this 
    then
      echo -e "Installing $2 is .... $G Succesfull $N"
    else
      echo -e "Installing $2 is .... $R Failure $N"   
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
   echo -e "Nginx is already $Y installed no changes to do $N !"
fi 

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install it"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo -e "Nothing to do MySQL... $Y already installed $N"
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