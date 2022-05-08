# static-s3-website-cloudfront

Before running the script, Please ensure that you have configured your AWS profile on your linux machine.

Do not forget to replace the variable `bucket_name` value with the bucket name you are creating. Also change the bucket name in line number 47.

**NOTE**:
The cloudfront URL will be available in the console/terminal once the script finishes. It is recommended to wait for 5 minutes to get the cloudfront distribution deployed successfully.

**To run the script**

`git clone https://github.com/devsecopsgirl/static-s3-website-cloudfront.git`

`cd static-s3-website-cloudfront`

`sh bashscript.sh`
