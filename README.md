docker-jbpm
===========

Setup
-----

### Create the parsistent data container

```
docker run -d --name kie-data -v /opt/kie-data busybox 
```

### Create the MySQL database on the container host.

Login your MySQL and create user like this.

```
create database jbpm;
create user 'jbpm'@'localhost' identified by 'jbpm';
grant all privileges on jbpm.* to 'jbpm'@'localhost' with grant option;

```

Setup the database with the user you create.

```
mysql -u jbpm -p jbpm < mysql5-jbpm-schema.sql
mysql -u jbpm -p jbpm < quartz_tables_mysql.sql
```

SQL files are in ```jbpm-6.1.0.Final-installer-full.zip```.
The zip file will be in sourceforge.net.

### Pull the worker container

```
docker run -it --volumes-from kie-data -p 8086:8080 monami0ya/jbpm 
```

You'll see the login page on ```http://localhost:8086/jbpm-console/```.
Don't worry when you got 404 errors. Retry after 5 minutes or more.

Serurity notice
---------------

The web server in this container is listening IP address 0.0.0.0. Not 127.0.0.1.
So jbpm-console can be accessed by out of the box.
