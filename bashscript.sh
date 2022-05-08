#!/bin/bash

#creating variable

bucket_name="clisecuritycorner.cloud"
region="us-east-1"

echo "Clone the static website"

git clone https://github.com/cloudacademy/static-website-example.git 

echo "Installing AWS CLI"

sudo apt udpate
sudo apt install awscli -y
aws --version

echo "Creating a S3 bucket"
aws s3api create-bucket --bucket $bucket_name --region $region

echo "Copy cloned data to bucket"
aws s3 cp static-website-example/ s3://$bucket_name/ --recursive

echo "Enable static website on bucket"
aws s3 website s3://$bucket_name/ --index-document index.html --error-document error.html

echo "Public access"
aws s3api put-public-access-block \
    --bucket $bucket_name \
    --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# echo "download policy.json"
# wget https://gist.githubusercontent.com/devsecopsgirl/653836952a469d2efa20dee7bf7c4b41/raw/5691e0b88c6a9294189934972b6cb1f3919c69ea/bucket-policy.json

# echo "Attach read object policy to S3 bucket"
# aws s3api put-bucket-policy --bucket $bucket_name --policy file://policy.json

echo "update the bucket policy"
aws s3api put-bucket-policy --bucket $bucket_name --policy "{
  \"Version\": \"2012-10-17\",
  \"Statement\": [
      {
          \"Sid\": \"PublicReadGetObject\",
          \"Effect\": \"Allow\",
          \"Principal\": \"*\",
          \"Action\": \"s3:GetObject\",
          \"Resource\": \"arn:aws:s3:::clisecuritycorner.cloud/*\"
      }
  ]
}"

echo "Setting up cloudfront"
aws cloudfront create-distribution --origin-domain-name $bucket_name.s3.us-east-1.amazonaws.com --default-root-object index.html
