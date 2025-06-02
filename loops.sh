#! /bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("Nginx" "python" "msql")

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
for package in ${PACKAGES[@]}
# for package in $@ -- to run by using arguments from command line
do 
  dnf list installed $PACKAGES &>>$LOG_FILE
  if [ $? -ne 0 ]
  then
      echo "$Y $package is not installed... going to install it now $N " | tee -a $LOG_FILE
      dnf install $package -y &>>$LOG_FILE
      VALIDATE $? "$package"
  else
      echo -e "Nothing to do $package... $Y already installed $N" | tee -a $LOG_FILE
  fi
done