[root@tecmint ~]# mkdir /mnt/cdrom
[root@tecmint ~]# mount /dev/cdrom /mnt/cdrom
[root@tecmint ~]# cd /mnt/cdrom/
[root@tecmint ~]# $ ls -l
[root@tecmint ~]# vi /etc/yum.repos.d/centos7.repo


Add

[centos7]
name=centos7
baseurl=file:///mnt/cdrom/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7



[root@tecmint ~]# yum --disablerepo=* --enablerepo=rhel7 groupinstall "Server with GUI"
