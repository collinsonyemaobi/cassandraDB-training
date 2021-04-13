
 --------------------   pip install cassandra-driver # Python drivers
#How to Install Apache Cassandra on Ubuntu 18.04

https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
sudo tar xvf jdk-8u221-linux-x64.tar.gz --directory /usr/lib/jvm/ 
/usr/lib/jvm/jdk1.8.0_221/bin/java -version

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_221/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_221/bin/javac 1

sudo update-alternatives --config java
-- =====================================	

sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt install oracle-java12-installer
sudo apt install oracle-java12-set-default


sudo apt remove oracle-java12-installer --purge
sudo apt remove oracle-java12-set-default
sudo apt autoremove

--=====
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update

	sudo apt install openjdk-8-jdk


#Install the apt-transport-https package that necessary to access a repository over HTTPS:
sudo apt install apt-transport-https
#Import the repository’s GPG using the following wget command:
wget -q -O - https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
#Next, add the Cassandra repository to the system by issuing:
sudo sh -c 'echo "deb http://www.apache.org/dist/cassandra/debian 311x main" > /etc/apt/sources.list.d/cassandra.list'


#update the apt package list and install the latest version 
	sudo apt-get update && apt-get upgrade
	sudo apt install cassandra ntp


#Enable Cassandra on system boot and verify that it is running:

	systemctl enable cassandra
	systemctl start cassandra
	systemctl -l status cassandra

#Check the status of the Cassandra cluster:
	nodetool status

#If you are receiving connection errors, open the cassandra-env.sh file in a text editor:
	gedit /etc/cassandra/cassandra-env.sh
JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=127.0.0.1" 
systemctl restart Cassandra 
#Configure Cassandra

	cp /etc/cassandra/cassandra.yaml /etc/cassandra/cassandra.yaml.backup
	sudo gedit /etc/cassandra/cassandra.yaml
	#Match the following variables in the file to the values shown below.
	. . .

	authenticator: PasswordAuthenticator
	authorizer: CassandraAuthorizer
	role_manager: CassandraRoleManager
	roles_validity_in_ms: 0
	permissions_validity_in_ms: 0

	. . .
	#After editing the file restart Cassandra.
	systemctl restart cassandra

#Add An Administration SuperuserPermalink
	#default user “cassandra”:
	cqlsh -u cassandra -p cassandra

	#Create a new superuser. Replace the brackets as well as the content inside with the applicable information:
	cassandra@cqlsh> CREATE ROLE [new_superuser] WITH PASSWORD = '[secure_password]' AND SUPERUSER = true AND LOGIN = true;
CREATE ROLE collins WITH PASSWORD = 'collins' AND SUPERUSER = true AND LOGIN = true;
	exit

	#Log back in with the new superuser account using the new credentials, and remove the elevated permissions from the Cassandra account:

	superuser@cqlsh> ALTER ROLE cassandra WITH PASSWORD = 'cassandra' AND SUPERUSER = false AND LOGIN = false;
	superuser@cqlsh> REVOKE ALL PERMISSIONS ON ALL KEYSPACES FROM cassandra;

	#Grant all permissions to the new superuser account. Replace the brackets and contents inside with your superuser account username:
	superuser@cqlsh> GRANT ALL PERMISSIONS ON ALL KEYSPACES TO [superuser];
GRANT ALL PERMISSIONS ON ALL KEYSPACES TO collins;
	#Log out by typing 
	exit
#Rename the Cluster --Update your default cluster name from “Test Cluster” to your desired name.
	#Login to the control terminal with cqlsh.
	UPDATE system.local SET cluster_name = 'Pyvault Cluster' WHERE KEY = 'local';

	#Edit the cassandra.yaml file and replace the value in the cluster_name variable with the new cluster name you just set.
	gedit /etc/cassandra/cassandra.yaml
		cluster_name: 'Linuxize Cluster'

	#Save and close.

	#From the Linux terminal (not cqlsh), run
	nodetool flush system. #This will clear the system cache and preserve all data in the node.

	#Restart Cassandra. 
	sudo systemctl restart cassandra 
	
	#Log in with cqlsh and verify the new cluster name is visible.
	cqlsh

--= =========================================================================================
# TO get the cluster_name AND  listen_address
cqlsh> select cluster_name, listen_address from system.local;



-- =================================================================

CREATE TABLE employee (
emp_id int,
company varchar,
first_name varchar,
last_name varchar,
email list<text>,
PRIMARY KEY ((emp_id, company), last_name));
