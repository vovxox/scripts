// check existing java version
java -version

// install java 8
sudo yum install java-1.8.0

// check which java version acting
java -version

// if its not the one you installed then run the below command to set the java version. 
sudo sudo update-alternatives --config java

//if you want to uninstall existing java
sudo yum remove java
