#! /bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/Shellscript-logs"
SOURCE_DIR=/home/ec2-user/log-files
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

#checkif user has root privilages or not 
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
      echo -e "$2 is .... $G Succesfull $N" | tee -a $LOG_FILE
    else
      echo -e "$2 is .... $R Failure $N" | tee -a $LOG_FILE
      exit 1
    fi
}
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +10)

while IFS= read -r filepath
do
   echo "Deleting file: $filepath" | tee -a $LOG_FILE
   rm -rf $filepath
done <<< $FILES_TO_DELETE

echo "Script ended at: $(date)"  | tee -a $LOG_FILE