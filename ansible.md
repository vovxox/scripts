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

#install ansible with YUM
yum install ansible

# ansible version
ansible --version


# validate ansible installation
rpm -qa | grep ansible


#open ansible package 
rpm -ql <package name> | more


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
useradd -d /home/ansadm -m ansadm

# create password for this user. a non expiry password
passwd -x -l ansdm


#setup SSH keys for newly created user 'ansadm'. so switch to the new user from root.
su - ansadm

#create rsa key for ansadm user.
# setup ssh keys for password less communication with external system
ssh-keygen -t rsa

#check the keys
cat <location of id_rsa.pub file>

cat /home/<username>/.ssh/id_rsa.pub
cat /home/ansadm/.ssh/id_rsa.pub

########## Ansible host/control node part ends##########

########## Client node part starts##########

#now create the users in your client/node servers. which are basically app/web/db servers.  same user to create.
useradd -d /home/ansadm -m ansadm
passwd -x -l ansdm

# setup keys in client nodes
# in client node, change user from root to ansadm
su - ansadm

#create directory under  'ansadm' profile home
mkdir .ssh

#change directory permisstion
chmod 700 .ssh/

#make owner of directory ansadm
chown ansadm:ansadm .ssh/
cd .ssh/

#create an authorize key file 
vi authorized_keys

# paste the key from ansible control/host server.  
# get the rsa key from ansible host server location cat /home/ansadm/.ssh/id_rsa.pub

#save the authorized_keys file and set the file owner as ansadm
chown ansadm:ansadm authorized_keys

#check file permission
ls -l

#change the permission to 600
chmod 600 authorized_keys

do the same things in all the client nodes

########## Client node part ends

########## Back to Ansible host/control node ends##########

# check hosts in ansible host
cat /etc/hosts
paste the ips of the client/node servers

like 

############below naes are hostnames or fqdn names for node machines

[webservers]
127.67.89.345
167.45.59.35
serv1.awstechguide.com
serv2.awstechguide.com

[dbervers]
35.267.86.45
16.145.29.5
dbserv1.awstechguide.com
dbserv2.awstechguide.com
############

group them as dbserver or webserver

# check connection from host to node. it should communicate password less
ssh dbserver



#check the permission
ls -l /etc/ansible -- main directory where inventory is saved
by default the owner will be root root

# change the owner to new user 'ansadm' recursively
chown -R ansadm:ansadm /etc/ansible

################ Ansible configuration
ls -l /etc/ansible/hosts -- inventory file 
vim /etc/ansible/hosts

# check configuration file 
ls -l /etc/ansible/ansible.cfg
vim /etc/ansible/ansible.cfg

#check modules of ansible
ansible-doc -l | more

it will list module name and desc

#what functions this particular modules can doc
ansible-doc -s <module name>
ansible-doc -s yum

#if you want to ping to client nodes
ansible <groupname> -m <modulename>
ansible webservers -m ping

#if you want to ping all groups in inventory
ansible all -m ping
ansible all -m ping -o (-o means output in single line)

# shell module. run a shell command to pull system info in ansible host
ansible all -m shell -a "uname -a:df -h"  

ansible all -m shell -a "uname -a:df -h"  -v (-v for verbose)
 
 







