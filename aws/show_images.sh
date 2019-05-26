#By me
aws --region us-east-1 ec2 describe-images --owners self --query "Images[*].[ImageId,Name]" --output text

#All
aws --region us-east-1 ec2 describe-images --owners amazon --query "Images[*].[ImageId,Name]" --output text
