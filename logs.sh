#! /bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

echo "Script execution is started at :- $(date)" | tee -a $LOG_FILE


if [ $USERID -ne 0 ]
then
   echo "ERROR: $R Please run the script with root access $N " | tee -a $LOG_FILE
   exit 1 # give other than 0 till 127
else
   echo "You are running with root access" | tee -a $LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ] # it will pass the exit status args VALIDATE $? "nginx" as $1 and $2 to this 
    then
      echo -e "Installing $2 is .... $G Succesfull $N" | tee -a $LOG_FILE
    else
      echo -e "Installing $2 is .... $R Failure $N" | tee -a $LOG_FILE
      exit 1
    fi
}

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then 
  echo "nginx is going to install now " | tee -a $LOG_FILE
  dnf install nginx -y &>>$LOG_FILE
  VALIDATE $? "nginx"
else
   echo -e "Nginx is already  installed $Y no changes to do $N !" | tee -a $LOG_FILE
fi 

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "$Y MySQL is not installed... going to install it $N " | tee -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "MySQL"
else
    echo -e "Nothing to do MySQL... $Y already installed $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "$Y python3 is not installed... going to install it $N " | tee -a $LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "Nothing to do python... $Y already installed $N" | tee -a $LOG_FILE
fi
