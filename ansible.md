#ansible

# documentation:
https://docs.ansible.com/


#installation
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

########## Ansible host/control node part starts##########
# server details
uname -a

# list repos in server
yum repolist

Installation:
1. launch RHEL ec2
2. sudo yum update
(change to sudo users)
3. Install RPEL. get RPEL link from https://fedoraproject.org/wiki/EPEL
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

#install ansible with YUM
yum install ansible

# ansible version
ansible --version


# validate ansible installation
rpm -qa | grep ansible


#open ansible package 
rpm -ql <package name> | more
rpm -ql ansible-2.9.7-1.el8.noarch | more


# /etc/ansible -- main config directory
# /etc/ansible/ansible.cfg -- config file
# /etc/ansible/hosts -- all clients info saved. ansible inventory directory. client name , server names saved here
# /etc/ansible/roles

# few ansible commands

# /usr/bin/ansible
# /usr/bin/ansible-console
# /usr/bin/ansible-doc
# /usr/bin/ansible-galaxy
# /usr/bin/ansible-playbook
# /usr/bin/ansible-pull
# /usr/bin/ansible-vault


# create an user for ansible . make sure you are creating it as root
useradd -d /home/awstechguide -m awstechguide

# create password for this user. a non expiry password
passwd awstechguide
passwd -x -1 awstechguide


#################################connect remote host ###############################

# create user in remote. best practice is not to use root user for ansible connection
useradd -d /home/awstechguideremote -m awstechguideremote
passwd -x -1 ansdm

# setup keys in client nodes

# in client node, change user from root to awstechguideremote
su - awstechguideremote

#create directory under  'awstechguideremote' profile home
mkdir .ssh

#change directory permisstion
chmod 700 .ssh/

#make owner of directory awstechguideremote
chown awstechguideremote:awstechguideremote .ssh/
cd .ssh/

#create key
ssh-keygen

#create an authorize key file 
vi authorized_keys

#save the authorized_keys file and set the file owner as awstechguide
chown awstechguidedb:awstechguidedb authorized_keys

#check file permission
ls -l

#change the permission to 600
chmod 600 authorized_keys


###########Go to Ansible etc/ansible###################

# create a key file by any name from private key of remote host which you copied

[root@ip-172-31-83-158 ansible]# vi remote-ec2-dbserver.key
# change permission
[root@ip-172-31-83-158 ansible]# chmod 600 remote-ec2-dbserver.key

# edit hosts file 
[dbservers] # groupname
<remote host ip> ansible_ssh_user=<remote host user> ansible_ssh_private_key_file=<private key file path of remote host in ansible host>
18.207.206.186 ansible_ssh_user=awstechguidedb ansible_ssh_private_key_file=/etc/ansible/remote-ec2-dbserver.key


###############
# update host with remote ip by group
vi /etc/ansible/hosts

[webservers]
54.164.166.210

[dbservers]
18.207.206.186


# connect your remote host and update packages first
-- for Linux
sudo yum update
-- for ubuntu 
sudo apt-get update 

# generate key in remote host

--browse to '.ssh' directory in your user profile. If it doesnt exit create it
cd .ssh
awstg@node1-ans:~$ cd .ssh
awstg@node1-ans:~/.ssh$ ll
total 8
drwx------ 2 awstg awstg 4096 May 19 13:50 ./
drwxr-xr-x 5 awstg awstg 4096 May 19 14:02 ../
-rw------- 1 awstg awstg    0 May 19 13:50 authorized_keys

#run 
ssh-keygen

awstg@node1-ans:~/.ssh$ ssh-keygen
Generating public/private rsa key pair. 
Enter file in which to save the key (/home/awstg/.ssh/id_rsa): ******* just press enter
Enter passphrase (empty for no passphrase): ******* just press enter
Enter same passphrase again:***** just press enter
Your identification has been saved in /home/awstg/.ssh/id_rsa.
Your public key has been saved in /home/awstg/.ssh/id_rsa.pub.


# id_rsa.pub is public key. id_rsa is private key
# VERY IMPORTANT STEP: 
# [ remote host ]copy public key in authorized_keys
# copy private key of remotehost from id_rsa and in ansible host system under /etc/ansible  create a new file with any name. like remotehost.key. and past the private key which you copied 
# from remotehost
awstg@remotehost:~/.ssh$ cat id_rsa.pub
#copy the public key in authorized_keys file 
awstg@remotehost:~/.ssh$ vi authorized_keys

# open and copy private key id_rsa from remote host
awstg@remotehost:~/.ssh$ cat id_rsa

#go to ansible host/controller 
#create a new file under /etc/ansible.  say remotehost1.key. and paste the private key copied from remotehost

[root@ip-172-31-83-158 ansible]# ll
total 28
-rw-r--r--. 1 root root 19985 May 13 04:01 ansible.cfg
-rw-r--r--. 1 root root  1221 May 19 13:58 hosts
drwxr-xr-x. 2 root root     6 May 13 04:01 roles
[root@ip-172-31-83-158 ansible]# vi remotehost1.key

# update file permission
chmod 600 remotehost1.key

#test ssh connection from ansible host/controller to remote hosts
ssh -p22 -i /etc/ansible/remotehost1.key <remotehost username>@<remote host ip>
ssh -p22 -i /etc/ansible/remotehost1.key ec2-user@54.164.166.210

ssh -p22 -i /etc/ansible/remote-ec2-dbserver.key awstechguidedb@18.207.206.186

#update vi etc/ansible/host
[webservers]
54.164.166.210 ansible_ssh_user=<hostname of remote system> ansible_ssh_private_key_file=<key file location in ansible host to connect the particular remote host>
54.164.166.210 ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/etc/ansible/remotehost1.key

#ping remote host by group name . dbservers
ansible dbservers -m ping
####################################################################################
