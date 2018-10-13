#!/bin/bash

python3 /src/assign_1/web_scrape.py $companyId  $accessionId 

mv /src/*zip /src/assign_1/out/
mv /src/Edgar*.log /src/assign_1/out/

echo "Files moved"

AK=$access_key
SK=$secret_key


echo $access_key
echo $secret_key

# Use curl command to upload file at S3 bucket.
#upload to S3 bucket 
sourceFilePath="/src/assign_1/out/Edgar_files.zip";
#file path at S3
filePathAtS3="ADS/Edgar_files.zip";
#Your S3 bucket name
bucket="akiaiucdulapjsfvjjdq-dump";
#S3 HTTP Resource URL for your file
resource="/${bucket}/${filePathAtS3}";
#set content type
contentType="application/zip";
#get date as RFC 7231 format
dateValue=`date -jnu +%a,\ %d\ %h\ %Y\ %T\ %Z`;
#String to generate signature
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}";
#your S3 key. This is specific to S3. This is not your AWS username.
s3Key="$AK";
#your S3 secret. This is specific to S3. This is not your AWS password.
s3Secret="$SK";
#Generate signature, Amazon re-calculates the signature and compares if it matches the one that was contained in your request. That way the secret access key never needs to be transmitted over the network.
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`;
#Use curl to make PUT request. 
curl -L -X PUT -T "${sourceFilePath}" \
 -H "Host: s3.amazonaws.com" \
 -H "Date: ${dateValue}" \
 -H "Content-Type: ${contentType}" \
 -H "Authorization: AWS ${s3Key}:${signature}" \
 https://s3.amazonaws.com/${bucket}/${filePathAtS3}


log_file_path="/src/assign_1/out/"
log_file_name=`ls /src/assign_1/out/*.log| xargs -n 1 basename`

echo $log_file_path
echo $log_file_name

sourceFilePath="${log_file_path}/${log_file_name}"

#file path at S3
filePathAtS3="ADS/$log_file_name";
#Your S3 bucket name
bucket="akiaiucdulapjsfvjjdq-dump";
#S3 HTTP Resource URL for your file
resource="/${bucket}/${filePathAtS3}";
#set content type
contentType="application/zip";
#get date as RFC 7231 format
dateValue=`date -jnu +%a,\ %d\ %h\ %Y\ %T\ %Z`;
#String to generate signature
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}";
#your S3 key. This is specific to S3. This is not your AWS username.
s3Key="$AK";
#your S3 secret. This is specific to S3. This is not your AWS password.
s3Secret="$SK";
#Generate signature, Amazon re-calculates the signature and compares if it matches the one that was contained in your request. That way the secret access key never needs to be transmitted over the network.
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`;
#Use curl to make PUT request. 
curl -L -X PUT -T "${sourceFilePath}" \
 -H "Host: s3.amazonaws.com" \
 -H "Date: ${dateValue}" \
 -H "Content-Type: ${contentType}" \
 -H "Authorization: AWS ${s3Key}:${signature}" \
 https://s3.amazonaws.com/${bucket}/${filePathAtS3}
 
 echo "Files sent to S3"
 