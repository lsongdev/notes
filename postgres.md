---
title: PostgresSQL
layout: default
---

# PostgresSQL

Postgres is a relational database management system.

## Getting started

### Getting started

Switch and connect 

```shell
$ sudo -u postgres psql
```

List all databases
```shell
postgres=# \l
```

Connect to the database named postgres 

```shell
postgres=\# \c postgres
```

Disconnect
```shell
postgres=# \q
postgres=# \!
```

### psql commands

| Option | Example | Description |
| :--- | :--- | :--- |
| `[-d] <database>` | psql -d mydb | Connecting to database |
| `-U` | psql -U john mydb | Connecting as a specific user |
| `-h` `-p` | psql -h localhost -p 5432 mydb | Connecting to a host/port |
| `-U` `-h` `-p` `-d` | psql -U admin -h 192.168.1.5 -p 2506 -d mydb | Connect remote PostgreSQL |
| `-W` | psql -W mydb | Force password |
| `-c` | psql -c '\c postgres' -c '\dt' | Execute a SQL query or command |
| `-H` | psql -c "\l+" -H postgres &gt; database.html | Generate HTML report |
| `-l` | psql -l | List all databases |
| `-f` | psql mydb -f file.sql | Execute commands from a file |
| `-V` | psql -V | Print the psql version |

### Getting help

| - | - |
| :--- | :--- |
| `\h` | Help on syntax of SQL commands |
| `\h` DELETE | DELETE SQL statement syntax |
| `\?` | List of PostgreSQL command |

Run in PostgreSQL console

## Working

### Recon

Show version

```sql
SHOW SERVER_VERSION;
```

Show system status 

```sql
\conninfo
```

Show environmental variables
```sql
SHOW ALL;
```

List users 

```sql
SELECT rolname FROM pg\_roles;
```

Show current user
```sql
SELECT current_user;
```

Show current user's permissions

```
\du
```

Show current database 

```sql
SELECT current\_database();
```

Show all tables in database
```sql
\dt
```

List functions 

```sql
\df
```

### Databases

List databases
```sql
\l
```

Connect to database 

```sql
\c
```

Show current database
```sql
SELECT current_database();
```

[Create database](http://www.postgresql.org/docs/current/static/sql-createdatabase.html) 

```sql
CREATE DATABASE WITH OWNER ;
```

[Drop database](http://www.postgresql.org/docs/current/static/sql-dropdatabase.html)
```sql
DROP DATABASE IF EXISTS <database_name>;
```

[Rename database](http://www.postgresql.org/docs/current/static/sql-alterdatabase.html) 

```sql
ALTER DATABASE RENAME TO ;
```

### Tables

List tables, in current db
```sql
\dt

SELECT table_schema,table_name FROM information_schema.tables ORDER BY table_schema,table_name;
```

List tables, globally 

```sql
\dt _._.
```

SELECT \* FROM pg\_catalog.pg\_tables

List table schema
```sql
\d <table_name>
\d+ <table_name>

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = '<table_name>';
```

[Create table](http://www.postgresql.org/docs/current/static/sql-createtable.html) 

```sql
CREATE TABLE \( , \);
```

Create table, with an auto-incrementing primary key
```sql
CREATE TABLE <table_name> (
  <column_name> SERIAL PRIMARY KEY
);
```

[Delete table](http://www.postgresql.org/docs/current/static/sql-droptable.html) 

```sql
DROP TABLE IF EXISTS CASCADE;
```

### Permissions
Become the postgres user, if you have permission errors
```shell
sudo su - postgres
psql
```

[Grant](http://www.postgresql.org/docs/current/static/sql-grant.html) all permissions on database 

```sql
GRANT ALL PRIVILEGES ON DATABASE TO ;
```

Grant connection permissions on database
```sql
GRANT CONNECT ON DATABASE <db_name> TO <user_name>;
```

Grant permissions on schema 

```sql
GRANT USAGE ON SCHEMA public TO ;
```

Grant permissions to functions
```sql
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO <user_name>;
```

Grant permissions to select, update, insert, delete, on a all tables 

```sql
GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO ;
```

Grant permissions, on a table
```sql
GRANT SELECT, UPDATE, INSERT ON <table_name> TO <user_name>;
```

Grant permissions, to select, on a table 

```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ;
```

### Columns

[Add column](http://www.postgresql.org/docs/current/static/sql-altertable.html)
```sql
ALTER TABLE <table_name> IF EXISTS
ADD <column_name> <data_type> [<constraints>];
```

Update column 

```sql
ALTER TABLE IF EXISTS ALTER TYPE \[\];
```

Delete column
```sql
ALTER TABLE <table_name> IF EXISTS
DROP <column_name>;
```

Update column to be an auto-incrementing primary key 

```sql
ALTER TABLE ADD COLUMN SERIAL PRIMARY KEY;
```

Insert into a table, with an auto-incrementing primary key
```sql
INSERT INTO <table_name>
VALUES (DEFAULT, <value1>);


INSERT INTO <table_name> (<column1_name>,<column2_name>)
VALUES ( <value1>,<value2> );
```

### Data

\[Select\]\([http://www.postgresql.org/docs/current/static/sql-select.html](http://www.postgresql.org/docs/current/static/sql-select.html)\] all data 

```sql
SELECT \* FROM ;
```

Read one row of data
```sql
SELECT * FROM <table_name> LIMIT 1;
```

Search for data 

```sql
SELECT \* FROM WHERE = ;
```

[Insert](http://www.postgresql.org/docs/current/static/sql-insert.html) data
```sql
INSERT INTO <table_name> VALUES( <value_1>, <value_2> );
```

[Update](http://www.postgresql.org/docs/current/static/sql-update.html) data 

```sql
UPDATE SET = , = WHERE = ;
```

[Delete](http://www.postgresql.org/docs/current/static/sql-delete.html) all data
```sql
DELETE FROM <table_name>;
```

Delete specific data 

```sql
DELETE FROM WHERE = ;
```

### Users

List roles
```sql
SELECT rolname FROM pg_roles;
```

[Create user](http://www.postgresql.org/docs/current/static/sql-createuser.html) 

```sql
CREATE USER WITH PASSWORD '';
```

[Drop user](http://www.postgresql.org/docs/current/static/sql-dropuser.html)
```sql
DROP USER IF EXISTS <user_name>;
```

[Alter](http://www.postgresql.org/docs/current/static/sql-alterrole.html) user password 

```sql
ALTER ROLE WITH PASSWORD '';
```

### Schema
List schemas
```sql
\dn

SELECT schema_name FROM information_schema.schemata;

SELECT nspname FROM pg_catalog.pg_namespace;
```

[Create schema](http://www.postgresql.org/docs/current/static/sql-createschema.html) 

```sql
CREATE SCHEMA IF NOT EXISTS ;
```

[Drop schema](http://www.postgresql.org/docs/current/static/sql-dropschema.html)
```sql
DROP SCHEMA IF EXISTS <schema_name> CASCADE;
```

## Commands

### Tables

| - | - |
| :--- | :--- |
| `\d <table>` | Describe table |
| `\d+ <table>` | Describe table with details |
| `\dt` | List tables from current schema |
| `\dt *.*` | List tables from all schemas |
| `\dt <schema>.*` | List tables for a schema |
| `\dp` | List table access privileges |
| `\det[+]` | List foreign tables |

### Query buffer

| - | - |
| :--- | :--- |
| `\e [FILE]` | Edit the query buffer \(or file\) |
| `\ef [FUNC]` | Edit function definition |
| `\p` | Show the contents |
| `\r` | Reset \(clear\) the query buffer |
| `\s [FILE]` | Display history or save it to file |
| `\w FILE` | Write query buffer to file |

### Informational

| - | - |
| :--- | :--- |
| `\l[+]` | List all databases |
| `\dn[S+]` | List schemas |
| `\di[S+]` | List indexes |
| `\du[+]` | List roles |
| `\ds[S+]` | List sequences |
| `\df[antw][S+]` | List functions |
| `\deu[+]` | List user mappings |
| `\dv[S+]` | List views |
| `\dl` | List large objects |
| `\dT[S+]` | List data types |
| `\da[S]` | List aggregates |
| `\db[+]` | List tablespaces |
| `\dc[S+]` | List conversions |
| `\dC[+]` | List casts |
| `\ddp` | List default privileges |
| `\dd[S]` | Show object descriptions |
| `\dD[S+]` | List domains |
| `\des[+]` | List foreign servers |
| `\dew[+]` | List foreign-data wrappers |
| `\dF[+]` | List text search configurations |
| `\dFd[+]` | List text search dictionaries |
| `\dFp[+]` | List text search parsers |
| `\dFt[+]` | List text search templates |
| `\dL[S+]` | List procedural languages |
| `\do[S]` | List operators |
| `\dO[S+]` | List collations |
| `\drds` | List per-database role settings |
| `\dx[+]` | List extensions |

`S`: show system objects, `+`: additional detail

### Connection

| - | - |
| :--- | :--- |
| `\c [DBNAME]` | Connect to new database |
| `\encoding [ENCODING]` | Show or set client encoding |
| `\password [USER]` | Change the password |
| `\conninfo` | Display information |

### Formatting

| - | - |  |
| :--- | :--- | :--- |
| `\a` | Toggle between unaligned and aligned |  |
| `\C [STRING]` | Set table title, or unset if none |  |
| `\f [STRING]` | Show or set field separator for unaligned |  |
| `\H` | Toggle HTML output mode |  |
| \`\t \[on | off\]\` | Show only rows |
| `\T [STRING]` | Set or unset HTML  tag attributes |  |
| \`\x \[on | off\]\` | Toggle expanded output |

### Input/Output

| - | - |
| :--- | :--- |
| `\copy ...` | Import/export table  _See also:_ [copy](postgres.md#import-export-csv) |
| `\echo [STRING]` | Print string |
| `\i FILE` | Execute file |
| `\o [FILE]` | Export all results to file |
| `\qecho [STRING]` | String to output stream |

### Variables

| - | - |
| :--- | :--- |
| `\prompt [TEXT] NAME` | Set variable |
| `\set [NAME [VALUE]]` | Set variable _\(or list all if no parameters\)_ |
| `\unset NAME` | Delete variable |

### Misc

| - | - |  |
| :--- | :--- | :--- |
| `\cd [DIR]` | Change the directory |  |
| \`\timing \[on | off\]\` | Toggle timing |
| `\! [COMMAND]` | Execute in shell |  |
| `\! ls -l` | List all in shell |  |

### Large Objects

* `\lo_export LOBOID FILE`
* `\lo_import FILE [COMMENT]`
* `\lo_list`
* `\lo_unlink LOBOID`

## Miscellaneous

### Backup

Use pg\_dumpall to backup all databases 

```shell
$ pg\_dumpall -U postgres &gt; all.sql
```

Use pg_dump to backup a database
```shell
$ pg_dump -d mydb -f mydb_backup.sql
```

* `-a`   Dump only the data, not the schema
* `-s`   Dump only the schema, no data
* `-c`   Drop database before recreating
* `-C`   Create database before restoring
* `-t`   Dump the named table\(s\) only
* `-F` Format \(`c`: custom, `d`: directory, `t`: tar\)


Use `pg_dump -?` to get the full list of options

### Restore

Restore a database with psql 

```shell
$ psql -U user mydb &lt; mydb\_backup.sql
```

Restore a database with pg_restore
```shell
$ pg_restore -d mydb mydb_backup.sql -c
```

* `-U`   Specify a database user
* `-c`   Drop database before recreating
* `-C`   Create database before restoring
* `-e`   Exit if an error has encountered
* `-F` Format \(`c`: custom, `d`: directory, `t`: tar, `p`: plain text sql\(default\)\)


Use `pg_restore -?` to get the full list of options

### Remote access

Get location of postgresql.conf 

```shell
$ psql -U postgres -c 'SHOW config\_file'
```

Append to postgresql.conf
```shell
listen_addresses = '*'
```

Append to pg\_hba.conf \(Same location as postgresql.conf\) 

```shell
host all all 0.0.0.0/0 md5 host all all ::/0 md5
```

Restart PostgreSQL server
```shell
$ sudo systemctl resatart postgresql
```

### Import/Export CSV

Export table into CSV file 

```shell
\copy table TO '' CSV \copy table\(col1,col1\) TO '' CSV \copy \(SELECT...\) TO '' CSV
```

Import CSV file into table
```shell
\copy table FROM '<path>' CSV
\copy table(col1,col1) FROM '<path>' CSV
```

See also: [Copy](https://www.postgresql.org/docs/current/sql-copy.html)

## See Also

* [Posgres-cheatsheet](https://gist.github.com/apolloclark/ea5466d5929e63043dcf#posgres-cheatsheet) _\(gist.github.com\)_

