#By me
aws ec2 describe-images --owners self --query 'Images[*].[ImageId,Name]' --output text

#All
aws ec2 describe-images --owners amazon --query 'Images[*].[ImageId,Name]' --output text
