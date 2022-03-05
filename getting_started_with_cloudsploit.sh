#!/bin/bash

echo "Getting ready..."
rm -rf /tmp/cloudsploit

if ! [ -x "$(command -v git)" ]; then
        echo "The git command is required! We're going to install it for you... soo you might get asked for sudo."
        sudo apt install git-all
        echo "git has been installed!"
fi
if ! [ -x "$(command -v npm)" ]; then
        echo "The npm command is required! We're going to install it for you... soo you might get asked for sudo."
        sudo apt install nodejs npm
        echo "npm has been installed!"
fi

mkdir /tmp/cloudsploit
cd /tmp/cloudsploit
git clone git@github.com:cloudsploit/scans.git
cd scans
npm install --silent
chmod +x index.js


## The cool thing to do would be READ and 
## throw it into a case statement block..

###########################################
############### AWS BLOCK #################
###########################################
CLOUD_TYPE="aws"

echo "Please enter the AWS ACCESS KEY ID:"
echo -e "AWS_ACCESS_KEY_ID: "
read AWS_ACCESS_KEY_ID
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}

echo "Please enter the AWS SECRET ACCESS KEY"
echo -e "AWS_SECRET_ACCESS_KEY: "
read AWS_SECRET_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

echo "What is the region that you're located primarily (example: us-east-1)?"
echo -e "AWS Region: "
read AWSREGION
export AWS_REGION=${AWSREGION}

###########################################

echo "Where do you want the csv exported..? (example: /Users/username/report.csv ) \n"
echo -e "File Location: "
read FILE_LOCATION

"./index.js" --cloud $CLOUD_TYPE --csv $FILE_LOCATION --console none
echo -e "\n\n\n\n"
echo "Please see $FILE_LOCATION for your CSV output!"


echo "..Cleaning up..."
cd /
rm -rf /tmp/cloudsploit
export AWS_SECRET_ACCESS_KEY=""
export AWS_ACCESS_KEY_ID=""
export AWS_REGION=""

echo "Have a nice day."