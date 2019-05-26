# Get instance-id of the instance we want to create an AMI of
ubuntu@ip-172-31-17-206:~$ aws ec2 describe-instances --output text --query 'Reservations[*].Instances[*].[Placement.AvailabilityZone,Tags[?Key==`Name`].Value | [0], InstanceId, State.Name]'
<...>

# Create AMI from running instance (note, instance will reboot)
ubuntu@ip-172-31-17-206:~$ aws ec2 create-image --instance-id i-0cbf9e991eafb1fc8 --name TestAMI2
{
    "ImageId": "ami-01e2a34d823c08a4e"
}

# View self AMI
ubuntu@ip-172-31-17-206:~$ aws ec2 describe-images --owners self --query 'Images[*].[ImageId,Name]' --output text
ami-01e2a34d823c08a4e   TestAMI2
ami-0953a7a8c67d2f1e4   TestAMI1
