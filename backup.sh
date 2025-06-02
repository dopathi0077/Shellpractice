#! /bin/bash

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-10} # if days are not provided in input then it will take 10 days default or it will take passed value

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/Shellpractice-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"


mkdir -p $LOGS_FOLDER

#checkif user has root privilages or not 
check_root(){
if [ $USERID -ne 0 ]
then
   echo "ERROR: $R Please run the script with root access $N " | tee -a $LOG_FILE
   exit 1 # give other than 0 till 127
else
   echo "You are running with root access" | tee -a $LOG_FILE
fi
}

VALIDATE(){
    if [ $1 -eq 0 ] # it will pass the exit status args VALIDATE $? "nginx" as $1 and $2 to this 
    then
      echo -e "$2 is .... $G Succesfull $N" | tee -a $LOG_FILE
    else
      echo -e "$2 is .... $R Failure $N" | tee -a $LOG_FILE
      exit 1
    fi
}

check_root
mkdir -p $LOGS_FOLDER

USAGE(){
    echo -e "$R USAGE: $N sh backup.sh <source-dir> <destination-dir> <days(optional)>"
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R Source Directory $SOURCE_DIR does not exist. Please check $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R Destination Directory $DEST_DIR does not exist. Please check $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime $DAYS)

if [ ! -z FILES ]
then 
    echo "files found"
else
     echo -e "No log files found older than 14 days ... $Y SKIPPING $N"
fi