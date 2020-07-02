
## update packages

sudo apt-get update

## install openjdk 8

sudo apt install openjdk-8-jdk 

## change user to sudo

sudo su

## browse to /opt. where we will install nexus

## get nexus binary 

wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.24.0-02-unix.tar.gz

tar -zxvf  nexus-3.24.0-02-unix.tar.gz

mv /opt/nexus-3.24.0-02 /opt/nexus

# change directory permission
chmod 700 /opt/nexus

## add user. (best practice to avoid root user. create new user)

sudo adduser nexus

## add priviledge to new user
 visudo \\ nexus   ALL=(ALL)       NOPASSWD: ALL

## change ownership to new user
sudo chown -R nexus:nexus /opt/nexus


## update /opt/nexus/bin/nexus.rc file, just uncomment run_as_user

vi /opt/nexus/bin/nexus.rc

run_as_user="nexus"

## Add nexus as a service at boot time

sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus


cd /etc/init.d

update-rc.d nexus defaults

service nexus start


http://nexuxserver url:8081  (default 8081). Make sure you have 8081 port in your security group (for AWS) / network rule (for Azure) / ingress rule ( for GCP) 

Use default credentials to login

username : admin

password : admin123
