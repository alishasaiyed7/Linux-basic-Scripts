#!/bin/bash


## Script for Monitoring Memory and Disk


THRESHOLD=80
EMAIL="XYZ@GMAIL.COM"

echo "==== Disk Usage Monitor Warning"

#1. Get Usage %

DISK_USAGE=$(df -h / awk 'NR==2 {print $5}' | sed 's/%//')

#Mmeory usage check

MEM_USAGE=$(free -h | grep Mem | awk '{print $3/$2 *100.0}' | awk '{print int($1)}')


#2 compare with threshold

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
  MESSAGE=" Warning, Disk usage is at ${DISK_USAGE}% on $(hostaname)"
  echo "MESSAGE"

  #send email alert
  echo "$MESSAGE" | mail -s "disk alert: $(hostname)" $EMAIL
else
  echo "Disk usage is normal : ${DISK_USAGE}%"



  #3 Check Memory

  if [ "$MEM_USAGE" -ge "$THRESHOLD" ]; then
  MESSAGE=" Warning, Memory sage is at ${MEM_USAGE}% on $(hostaname)"
  echo "MESSAGE"

  #send email alert
  echo "$MESSAGE" | mail -s "memory alert: $(hostname)" $EMAIL
else
  echo "memory  usage is normal : ${MEM_USAGE}%"
  



