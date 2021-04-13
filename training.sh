#Check the status of the Cassandra cluster:
	nodetool status 
#Add An Administration SuperuserPermalink
	#default user “cassandra”:
	cqlsh -u cassandra -p cassandra

#Create a new superuser. Replace the brackets as well as the content inside with the applicable information:

	CREATE ROLE collins WITH PASSWORD = 'collins' AND SUPERUSER = true AND LOGIN = true;
	

#Log back in with the new superuser account using the new credentials, and remove the elevated permissions from the Cassandra account:
	REVOKE ALL PERMISSIONS ON ALL KEYSPACES FROM cassandra;

	#Grant all permissions to the new superuser account. Replace the brackets and contents inside with your superuser account username:
	GRANT ALL PERMISSIONS ON ALL KEYSPACES TO collins;



--= =========================================================================================
# TO get the cluster_name AND  listen_address
select cluster_name, listen_address from system.local;



-- =================================================================


CREATE KEYSPACE IF NOT EXISTS pyvault_db
WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 1};

#Verification
DESCRIBE keyspaces;

USE pyvault_db;

DROP KEYSPACE pyvault_db;
	

CREATE TABLE footptint(name text PRIMARY KEY, email list<text>);

INSERT INTO footptint(name, email) VALUES ('collins',['grabsyntax@gmail.com','ooftish@yahoo.com']);

UPDATE footptint SET email = email +['xyz@pyvault.com'] where name = 'collins';

SELECT * FROM footptint;

SELECT * FROM footptint where name = 'collins';
SELECT * FROM footptint where email contains 'grabsyntax@gmail.com' ALLOW FILTERING;


# Create indexes to speed up operations
CREATE INDEX idx_name ON footptint (name);

#Using BATCH, you can execute multiple modification statements (insert, update, delete) simultaneiously. 
BEGIN BATCH
INSERT INTO footptint(name, email) VALUES ('esom',['esom@gmail.com','esom@yahoo.com']);
UPDATE footptint SET email = email +['esom@pyvault.com'] where name = 'esom';
DELETE email[1] FROM footptint  where name = 'collins';
APPLY BATCH;
