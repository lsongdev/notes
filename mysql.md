---
layout: default
title: MySQL
---

# MySQL

MySQL is a relational database management system. It is the most popular database system in the world.

## Getting started

### Connect MySQL

```shell
mysql -u <user> -p
mysql [db_name]
mysql -h <host> -P <port> -u <user> -p [db_name]
mysql -h <host> -u <user> -p [db_name]
```

### Commons

#### Database

| - | - |
| :--- | :--- |
| `create database` db `;` | Create database |
| `show databases;` | List databases |
| `use` db`;` | Switch to db |
| `drop database` db`;` | Delete db |

#### Table

| - | - |
| :--- | :--- |
| `show tables;` | List tables for current db |
| `show fields from` t`;` | List fields for a table |
| `desc` t`;` | Show table structure |
| `show create table`t`;` | Show create table sql |
| `truncate table`t`;` | Remove all data in a table |
| `drop table`t`;` | Delete table |

#### Proccess

| - | - |
| :--- | :--- |
| `show processlist;` | List processes |
| `kill` pid`;` | kill process |

#### Other

| - | - |
| :--- | :--- |
| `exit` or `\q` | Exit MySQL session |

### Backups

Create a backup

```shell
mysqldump -u user -p db_name > db.sql
```

Export db without schema

```shell
mysqldump -u user -p db_name --no-data=true --add-drop-table=false > db.sql
```

Restore a backup

```shell
mysql -u user -p db_name < db.sql
```

## Examples

### Managing tables

Create a new table with three columns

```sql
CREATE TABLE t (
     id INT PRIMARY KEY,
     name VARCHAR NOT NULL,
     price INT DEFAULT 0
);
```

Delete the table from the database

```sql
DROP TABLE t ;
```

Add a new column to the table

```sql
ALTER TABLE t ADD column;
```

Drop column c from the table

```sql
ALTER TABLE t DROP COLUMN c ;
```

Add a constraint

```sql
ALTER TABLE t ADD constraint;
```

Drop a constraint

```sql
ALTER TABLE t DROP constraint;
```

Rename a table from t1 to t2

```sql
ALTER TABLE t1 RENAME TO t2;
```

Rename column c1 to c2

```sql
ALTER TABLE t1 RENAME c1 TO c2 ;
```

Remove all data in a table

```sql
TRUNCATE TABLE t;
```

### Querying data from a table

Query data in columns c1, c2 from a table

```sql
SELECT c1, c2 FROM t
```

Query all rows and columns from a table

```sql
SELECT * FROM t
```

Query data and filter rows with a condition

```sql
SELECT c1, c2 FROM t
WHERE condition
```

Query distinct rows from a table

```sql
SELECT DISTINCT c1 FROM t
WHERE condition
```

Sort the result set in ascending or descending order

```sql
SELECT c1, c2 FROM t
ORDER BY c1 ASC [DESC]
```

Skip offset of rows and return the next n rows

```sql
SELECT c1, c2 FROM t
ORDER BY c1 
LIMIT n OFFSET offset
```

Group rows using an aggregate function

```sql
SELECT c1, aggregate(c2)
FROM t
GROUP BY c1
```

Filter groups using HAVING clause

```sql
SELECT c1, aggregate(c2)
FROM t
GROUP BY c1
HAVING condition
```

### Querying from multiple tables

Inner join t1 and t2

```sql
SELECT c1, c2 
FROM t1
INNER JOIN t2 ON condition
```

Left join t1 and t1

```sql
SELECT c1, c2 
FROM t1
LEFT JOIN t2 ON condition
```

Right join t1 and t2

```sql
SELECT c1, c2 
FROM t1
RIGHT JOIN t2 ON condition
```

Perform full outer join

```sql
SELECT c1, c2 
FROM t1
FULL OUTER JOIN t2 ON condition
```

Produce a Cartesian product of rows in tables

```sql
SELECT c1, c2 
FROM t1
CROSS JOIN t2
```

Another way to perform cross join

```sql
SELECT c1, c2 
FROM t1, t2
```

Join t1 to itself using INNER JOIN clause

```sql
SELECT c1, c2
FROM t1 A
INNER JOIN t1 B ON condition
```

Using SQL Operators Combine rows from two queries

```sql
SELECT c1, c2 FROM t1
UNION [ALL]
SELECT c1, c2 FROM t2
```

Return the intersection of two queries

```sql
SELECT c1, c2 FROM t1
INTERSECT
SELECT c1, c2 FROM t2
```

Subtract a result set from another result set

```sql
SELECT c1, c2 FROM t1
MINUS
SELECT c1, c2 FROM t2
```

Query rows using pattern matching %, \_

```sql
SELECT c1, c2 FROM t1
WHERE c1 [NOT] LIKE pattern
```

Query rows in a list

```sql
SELECT c1, c2 FROM t
WHERE c1 [NOT] IN value_list
```

Query rows between two values

```sql
SELECT c1, c2 FROM t
WHERE  c1 BETWEEN low AND high
```

Check if values in a table is NULL or not

```sql
SELECT c1, c2 FROM t
WHERE  c1 IS [NOT] NULL
```

### Using SQL constraints

Set c1 and c2 as a primary key

```sql
CREATE TABLE t(
    c1 INT, c2 INT, c3 VARCHAR,
    PRIMARY KEY (c1,c2)
);
```

Set c2 column as a foreign key

```sql
CREATE TABLE t1(
    c1 INT PRIMARY KEY,  
    c2 INT,
    FOREIGN KEY (c2) REFERENCES t2(c2)
);
```

Make the values in c1 and c2 unique

```sql
CREATE TABLE t(
    c1 INT, c1 INT,
    UNIQUE(c2,c3)
);
```

Ensure c1 &gt; 0 and values in c1 &gt;= c2

```sql
CREATE TABLE t(
  c1 INT, c2 INT,
  CHECK(c1> 0 AND c1 >= c2)
);
```

Set values in c2 column not NULL

```sql
CREATE TABLE t(
     c1 INT PRIMARY KEY,
     c2 VARCHAR NOT NULL
);
```

### Modifying Data

Insert one row into a table

```sql
INSERT INTO t(column_list)
VALUES(value_list);
```

Insert multiple rows into a table

```sql
INSERT INTO t(column_list)
VALUES (value_list), 
       (value_list), …;
```

Insert rows from t2 into t1

```sql
INSERT INTO t1(column_list)
SELECT column_list
FROM t2;
```

Update new value in the column c1 for all rows

```sql
UPDATE t
SET c1 = new_value;
```

Update values in the column c1, c2 that match the condition

```sql
UPDATE t
SET c1 = new_value, 
        c2 = new_value
WHERE condition;
```

Delete all data in a table

```sql
DELETE FROM t;
```

Delete subset of rows in a table

```sql
DELETE FROM t
WHERE condition;
```

### Managing Views

Create a new view that consists of c1 and c2

```sql
CREATE VIEW v(c1,c2) 
AS
SELECT c1, c2
FROM t;
```

Create a new view with check option

```sql
CREATE VIEW v(c1,c2) 
AS
SELECT c1, c2
FROM t;
WITH [CASCADED | LOCAL] CHECK OPTION;
```

Create a recursive view

```sql
CREATE RECURSIVE VIEW v 
AS
select-statement -- anchor part
UNION [ALL]
select-statement; -- recursive part
```

Create a temporary view

```sql
CREATE TEMPORARY VIEW v 
AS
SELECT c1, c2
FROM t;
```

Delete a view

```sql
DROP VIEW view_name;
```

### Managing triggers

Create or modify a trigger

```sql
CREATE OR MODIFY TRIGGER trigger_name
WHEN EVENT
ON table_name TRIGGER_TYPE
EXECUTE stored_procedure;
```

#### WHEN

| - | - |
| :--- | :--- |
| `BEFORE` | invoke before the event occurs |
| `AFTER` | invoke after the event occurs |

#### EVENT

| - | - |
| :--- | :--- |
| `INSERT` | invoke for INSERT |
| `UPDATE` | invoke for UPDATE |
| `DELETE` | invoke for DELETE |

#### TRIGGER\_TYPE

| - | - |
| :--- | :--- |
| `FOR EACH ROW` |  |
| `FOR EACH STATEMENT` |  |

### Managing indexes

Create an index on c1 and c2 of the t table

```sql
CREATE INDEX idx_name 
ON t(c1,c2);
```

Create a unique index on c3, c4 of the t table

```sql
CREATE UNIQUE INDEX idx_name
ON t(c3,c4)
```

Drop an index

```sql
DROP INDEX idx_name;
```

## Data Types

### Strings

| - | - |
| :--- | :--- |
| `CHAR` | String \(0 - 255\) |
| `VARCHAR` | String \(0 - 255\) |
| `TINYTEXT` | String \(0 - 255\) |
| `TEXT` | String \(0 - 65535\) |
| `BLOB` | String \(0 - 65535\) |
| `MEDIUMTEXT` | String \(0 - 16777215\) |
| `MEDIUMBLOB` | String \(0 - 16777215\) |
| `LONGTEXT` | String \(0 - 429496­7295\) |
| `LONGBLOB` | String \(0 - 429496­7295\) |
| `ENUM` | One of preset options |
| `SET` | Selection of preset options |

### Date & time

| Data Type | Format |
| :--- | :--- |
| `DATE` | yyyy-MM-dd |
| `TIME` | hh:mm:ss |
| `DATETIME` | yyyy-MM-dd hh:mm:ss |
| `TIMESTAMP` | yyyy-MM-dd hh:mm:ss |
| `YEAR` | yyyy |

### Numeric

| - | - |
| :--- | :--- |
| `TINYINT x` | Integer \(-128 to 127\) |
| `SMALLINT x` | Integer \(-32768 to 32767\) |
| `MEDIUMINT x` | Integer \(-8388608 to 8388607\) |
| `INT x` | Integer \(-2147­483648 to 214748­3647\) |
| `BIGINT x` | Integer \(-9223­372­036­854­775808 to 922337­203­685­477­5807\) |
| `FLOAT` | Decimal \(precise to 23 digits\) |
| `DOUBLE` | Decimal \(24 to 53 digits\) |
| `DECIMAL` | "­DOU­BLE­" stored as string |

## Functions & Operators

### Strings

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [ASCII()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ascii)              | Return numeric value of left-most character      |
| [BIN()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_bin)                  | Return a string containing binary representation of a number |
| [BIT\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_bit-length)    | Return length of argument in bits                |
| [CHAR()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_char)                | Return the character for each integer passed    |
| [CHARACTER\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_character-length) | Synonym for CHAR\_LENGTH()                 |
| [CHAR\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_char-length)  | Return number of characters in argument         |
| [CONCAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_concat)            | Return concatenated string                      |
| [CONCAT\_WS()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_concat-ws)      | Return concatenate with separator                |
| [ELT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_elt)                  | Return string at index number                   |
| [EXPORT\_SET()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_export-set)    | Return a string such that for every bit set in the value bits, you get an on string and for every unset bit, you get an off string |
| [FIELD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_field)              | Index (position) of first argument in subsequent arguments |
| [FIND\_IN\_SET()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_find-in-set) | Index (position) of first argument within second argument |
| [FORMAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_format)            | Return a number formatted to specified number of decimal places |
| [FROM\_BASE64()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_from-base64)  | Decode base64 encoded string and return result   |
| [HEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_hex)                  | Hexadecimal representation of decimal or string value |
| [INSERT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_insert)            | Insert substring at specified position up to specified number of characters |
| [INSTR()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_instr)              | Return the index of the first occurrence of substring |
| [LCASE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lcase)              | Synonym for LOWER()                             |
| [LEFT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_left)                | Return the leftmost number of characters as specified |
| [LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_length)            | Return the length of a string in bytes           |
| [LIKE](https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html#operator_like)        | Simple pattern matching                         |
| [LOAD\_FILE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_load-file)      | Load the named file                              |
| [LOCATE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_locate)            | Return the position of the first occurrence of substring |
| [LOWER()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lower)              | Return the argument in lowercase                |
| [LPAD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lpad)                | Return the string argument, left-padded with the specified string |
| [LTRIM()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ltrim)              | Remove leading spaces                           |
| [MAKE\_SET()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_make-set)        | Return a set of comma-separated strings that have the corresponding bit in bits set |
| [MATCH](https://dev.mysql.com/doc/refman/8.0/en/fulltext-search.html#function_match)                  | Perform full-text search                        |
| [MID()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_mid)                  | Return a substring starting from the specified position |
| [NOT LIKE](https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html#operator_not-like)  | Negation of simple pattern matching             |
| [NOT REGEXP](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#operator_not-regexp)               | Negation of REGEXP                              |
| [OCT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_oct)                  | Return a string containing octal representation of a number |
| [OCTET\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_octet-length) | Synonym for LENGTH()                           |
| [ORD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ord)                  | Return character code for leftmost character of the argument |
| [POSITION()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_position)        | Synonym for LOCATE()                            |
| [QUOTE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_quote)              | Escape the argument for use in an SQL statement  |
| [REGEXP](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#operator_regexp)                        | Whether string matches regular expression       |
| [REGEXP\_INSTR()](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-instr)          | Starting index of substring matching regular expression |
| [REGEXP\_LIKE()](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-like)            | Whether stringmatches regular expression       |
| [REGEXP\_REPLACE()](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-replace)      | Replace substrings matching regular expression  |
| [REGEXP\_SUBSTR()](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-substr)        | Return substring matching regular expression    |
| [REPEAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_repeat)            | Repeat a string the specified number of times  |
| [REPLACE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_replace)          | Replace occurrences of a specified string       |
| [REVERSE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_reverse)          | Reverse the characters in a string              |
| [RIGHT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_right)              | Return the specified rightmost number of characters |
| [RLIKE](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#operator_regexp)                          | Whether string matches regular expression       |
| [RPAD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_rpad)                | Append string the specified number of times    |
| [RTRIM()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_rtrim)              | Remove trailing spaces                          |
| [SOUNDEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_soundex)          | Return a soundex string                         |
| [SOUNDS LIKE](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#operator_sounds-like)    | Compare sounds                                   |
| [SPACE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_space)              | Return a string of the specified number of spaces |
| [STRCMP()](https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html#function_strcmp)  | Compare two strings                              |
| [SUBSTR()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_substr)            | Return the substring as specified               |
| [SUBSTRING()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_substring)      | Return the substring as specified               |
| [SUBSTRING\_INDEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_substring-index) | Return a substring from a string before the specified number of occurrences of the delimiter |
| [TO\_BASE64()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_to-base64)      | Return the argument converted to a base-64 string |
| [TRIM()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_trim)                | Remove leading and trailing spaces              |
| [UCASE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ucase)              | Synonym for UPPER()                             |
| [UNHEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_unhex)              | Return a string containing hex representation of a number |
| [UPPER()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_upper)              | Convert to uppercase                            |
| [WEIGHT\_STRING()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_weight-string) | Return the weight string for a string          |

### Date and Time

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [ADDDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_adddate)    | Add time values (intervals) to a date value      |
| [ADDTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_addtime)    | Add time                                        |
| [CONVERT\_TZ()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_convert-tz) | Convert from one time zone to another         |
| [CURDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_curdate)    | Return the current date                         |
| [CURRENT\_DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_current-date) | Synonyms for CURDATE()                      |
| [CURRENT\_TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_current-time) | Synonyms for CURTIME()                    |
| [CURRENT\_TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_current-timestamp) | Synonyms for NOW()                   |
| [CURTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_curtime)    | Return the current time                         |
| [DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date)          | Extract the date part of a date or datetime expression |
| [DATE\_ADD()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-add)  | Add time values (intervals) to a date value      |
| [DATE\_FORMAT()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format) | Format date as specified                   |
| [DATE\_SUB()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-sub)  | Subtract a time value (interval) from a date   |
| [DATEDIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_datediff)    | Subtract two dates                              |
| [DAY()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_day)            | Synonym for DAYOFMONTH()                        |
| [DAYNAME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayname)    | Return the name of the weekday                  |
| [DAYOFMONTH()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayofmonth) | Return the day of the month (0-31)              |
| [DAYOFWEEK()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayofweek) | Return the weekday index of the argument        |
| [DAYOFYEAR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayofyear) | Return the day of the year (1-366)              |
| [EXTRACT()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_extract)    | Extract part of a date                          |
| [FROM\_DAYS()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_from-days) | Convert a day number to a date                  |
| [FROM\_UNIXTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_from-unixtime) | Format Unix timestamp as a date            |
| [GET\_FORMAT()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_get-format) | Return a date format string                  |
| [HOUR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_hour)          | Extract the hour                                |
| [LAST\_DAY](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_last-day)  | Return the last day of the month for the argument |
| [LOCALTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_localtime) | Synonym for NOW()                                |
| [LOCALTIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_localtimestamp) | Synonym for NOW()                         |
| [MAKEDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_makedate)  | Create a date from the year and day of year     |
| [MAKETIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_maketime)  | Create time from hour, minute, second           |
| [MICROSECOND()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_microsecond) | Return the microseconds from argument        |
| [MINUTE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_minute)      | Return the minute from the argument            |
| [MONTH()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_month)        | Return the month from the date passed           |
| [MONTHNAME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_monthname) | Return the name of the month                    |
| [NOW()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_now)            | Return the current date and time                |
| [PERIOD\_ADD()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_period-add) | Add a period to a year-month                |
| [PERIOD\_DIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_period-diff) | Return the number of months between periods |
| [QUARTER()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_quarter)    | Return the quarter from a date argument         |
| [SEC\_TO\_TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_sec-to-time) | Converts seconds to 'hh:mm:ss' format     |
| [SECOND()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_second)      | Return the second (0-59)                         |
| [STR\_TO\_DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_str-to-date) | Convert a string to a date                   |
| [SUBDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_subdate)    | Synonym for DATE\_SUB() when invoked with three arguments |
| [SUBTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_subtime)    | Subtract times                                   |
| [SYSDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_sysdate)    | Return the time at which the function executes   |
| [TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_time)          | Extract the time portion of the expression passed |
| [TIME\_FORMAT()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_time-format) | Format as time                              |
| [TIME\_TO\_SEC()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_time-to-sec) | Return the argument converted to seconds   |
| [TIMEDIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timediff)  | Subtract time                                   |
| [TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestamp) | With a single argument, this function returns the date or datetime expression; with two arguments, the sum of the arguments |
| [TIMESTAMPADD()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestampadd) | Add interval to datetime               |
| [TIMESTAMPDIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestampdiff) | Subtract datetime expressions          |
| [TO\_DAYS()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_to-days)    | Convert a date to days                         |
| [TO\_SECONDS()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_to-seconds) | Convert a time value to seconds           |
| [UNIX\_TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_unix-timestamp) | Return the current Unix timestamp       |
| [UTC\_DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_utc-date)  | Return the current UTC date                     |
| [UTC\_TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_utc-time)  | Return the current UTC time                     |
| [UTC\_TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_utc-timestamp) | Return the current UTC date and time   |
| [WEEK()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_week)          | Return the week number                           |
| [WEEKDAY()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_weekday)    | Return the weekday index (0 = Monday, 6 = Sunday) |
| [WEEKOFYEAR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_weekofyear) | Return the calendar week of the date (0-53)    |
| [YEAR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_year)          | Return the year from a date or datetime expression |
| [YEARWEEK()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_yearweek)  | Return the year and week number for a date or datetime |

### Numeric

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [ABS()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_abs)              | Return the absolute value of a number            |
| [ACOS()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_acos)            | Return the arc cosine of a number                |
| [ASIN()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_asin)            | Return the arc sine of a number                  |
| [ATAN2()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_atan2)          | Return the arc tangent of the two arguments      |
| [ATAN()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_atan)            | Return the arc tangent of a number               |
| [AVG()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_avg)                  | Return the average value of a group of values    |
| [BIT\_AND()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_bit-and)          | Return bitwise AND                                |
| [BIT\_OR()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_bit-or)            | Return bitwise OR                                 |
| [BIT\_XOR()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_bit-xor)          | Return bitwise XOR                                |
| [CEIL()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_ceil)            | Return the smallest integer value not less than a number |
| [CEILING()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_ceiling)      | Synonym for CEIL()                                |
| [COS()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_cos)              | Return the cosine of a number                    |
| [COT()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_cot)              | Return the cotangent of a number                 |
| [COUNT()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)              | Return the number of rows in a group             |
| [DEGREES()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_degrees)      | Convert radians to degrees                       |
| [DIV](https://dev.mysql.com/doc/refman/8.0/en/arithmetic-functions.html#operator_div)                    | Integer division                                 |
| [EXP()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_exp)              | Raise to the power of e                          |
| [FLOOR()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_floor)          | Return the largest integer value not greater than a number |
| [GREATEST()](https://dev.mysql.com/doc/refman/8.0/en/comparison-operators.html#function_greatest)      | Return the largest argument                      |
| [LEAST()](https://dev.mysql.com/doc/refman/8.0/en/comparison-operators.html#function_least)            | Return the smallest argument                     |
| [LN()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_ln)                | Return the natural logarithm of a number         |
| [LOG10()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_log10)          | Return the base-10 logarithm of a number         |
| [LOG2()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_log2)            | Return the base-2 logarithm of a number          |
| [LOG()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_log)              | Return the natural logarithm of a number         |
| [MAX()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_max)                  | Return the maximum value in a group of values    |
| [MIN()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_min)                  | Return the minimum value in a group of values    |
| [MOD()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_mod)              | Return the remainder of a division               |
| [PI()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_pi)                | Return the value of pi                           |
| [POW()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_pow)              | Return the result of raising a number to a power |
| [POWER()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_power)          | Synonym for POW()                                |
| [RADIANS()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_radians)      | Convert degrees to radians                       |
| [RAND()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_rand)            | Return a random floating-point value             |
| [ROUND()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_round)          | Round a number to a specified number of decimal places |
| [SIGN()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_sign)            | Return the sign of a number (1 for positive, 0 for zero, -1 for negative) |
| [SIN()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_sin)              | Return the sine of a number                      |
| [SQRT()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_sqrt)            | Return the square root of a number               |
| [SUM()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_sum)                  | Return the sum of values in a group              |
| [TAN()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_tan)              | Return the tangent of a number                   |
| [TRUNCATE()](https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html#function_truncate)    | Truncate to specified number of decimal places    |
| [UUID()](https://dev.mysql.com/doc/refman/8.0/en/miscellaneous-functions.html#function_uuid)            | Return a UUID value                               |

### Aggregate Functions

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [AVG()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_avg)                  | Return the average value of a group of values    |
| [BIT\_AND()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_bit-and)          | Return bitwise AND                                |
| [BIT\_OR()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_bit-or)            | Return bitwise OR                                 |
| [BIT\_XOR()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_bit-xor)          | Return bitwise XOR                                |
| [COUNT()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)              | Return the number of rows in a group             |
| [GROUP\_CONCAT()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_group-concat) | Concatenate string values from a group          |
| [MAX()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_max)                  | Return the maximum value in a group of values    |
| [MIN()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_min)                  | Return the minimum value in a group of values    |
| [STD()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_std)                  | Return the population standard deviation         |
| [STDDEV()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_stddev)            | Synonym for STD()                                |
| [STDDEV\_POP()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_stddev-pop)    | Return the population standard deviation         |
| [STDDEV\_SAMP()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_stddev-samp)  | Return the sample standard deviation             |
| [SUM()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_sum)                  | Return the sum of values in a group              |
| [VAR\_POP()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_var-pop)          | Return the population variance                   |
| [VAR\_SAMP()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_var-samp)        | Return the sample variance                       |
| [VARIANCE()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_variance)        | Synonym for VAR\_SAMP()                          |

### Control Flow Functions

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [CASE](https://dev.mysql.com/doc/refman/8.0/en/control-flow-functions.html#operator_case)                 | Case expression                                   |
| [IF()](https://dev.mysql.com/doc/refman/8.0/en/control-flow-functions.html#function_if)                  | Return a value based on a condition              |
| [IFNULL()](https://dev.mysql.com/doc/refman/8.0/en/control-flow-functions.html#function_ifnull)          | Return the first non-NULL argument                |
| [NULLIF()](https://dev.mysql.com/doc/refman/8.0/en/control-flow-functions.html#function_nullif)          | Return NULL if two expressions are equal          |

### String and Text Functions

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [ASCII()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ascii)                | Return the ASCII value of a character            |
| [BIN()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_bin)                    | Return a binary representation of a number       |
| [BIT\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_bit-length)      | Return the length of a string in bits            |
| [CHAR()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_char)                  | Return a character from an integer ASCII value   |
| [CHAR\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_char-length)    | Return the number of characters in a string      |
| [CHARACTER\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_character-length) | Synonym for CHAR\_LENGTH()              |
| [CONCAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_concat)              | Concatenate strings                               |
| [CONCAT\_WS()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_concat-ws)        | Concatenate with separator                        |
| [CONV()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_conv)                  | Convert numbers between different bases          |
| [CONVERT()](https://dev.mysql.com/doc/refman/8.0/en/cast-functions.html#function_convert)             | Cast a value as a different type                 |
| [ELT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_elt)                    | Return the N-th element of a list                |
| [EXPORT\_SET()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_export-set)     | Return a string with the set bits in integer values converted to words |
| [FIELD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_field)                | Return the index of a value in a list            |
| [FIND\_IN\_SET()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_find-in-set)   | Return the index position of a value in a set    |
| [FORMAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_format)              | Format a number                                   |
| [FROM\_BASE64()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_from-base64)   | Decode from base64                               |
| [HEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_hex)                    | Return a hexadecimal string                      |
| [INSERT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_insert)              | Insert a substring at a specified position       |
| [INSTR()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_instr)                | Return the index of the first occurrence of a substring |
| [LCASE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lcase)                | Convert a string to lowercase                    |
| [LEFT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_left)                  | Return the leftmost characters from a string     |
| [LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_length)              | Return the length of a string                    |
| [LOCATE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_locate)              | Return the position of the first occurrence of a substring |
| [LOWER()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lower)                | Synonym for LCASE()                               |
| [LPAD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lpad)                | Left-pad a string                                 |
| [LTRIM()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ltrim)              | Remove leading spaces from a string              |
| [MAKE\_SET()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_make-set)        | Return a set of comma-separated strings          |
| [MATCH()](https://dev.mysql.com/doc/refman/8.0/en/fulltext-search.html#function_match)                 | Perform full-text search                         |
| [MID()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_mid)                    | Return a substring from a string                 |
| [OCT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_oct)                    | Return a string representation of a number in octal |
| [OCTET\_LENGTH()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_octet-length)  | Return the length of a string in bytes           |
| [ORD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ord)                    | Return the Unicode code point for the leftmost character of a string |
| [POSITION()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_position)          | Synonym for LOCATE()                              |
| [QUOTE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_quote)                | Quote a string to produce a result that can be used as a properly escaped data value |
| [REPEAT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_repeat)              | Repeat a string a specified number of times      |
| [REPLACE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_replace)            | Replace occurrences of a substring                |
| [REVERSE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_reverse)            | Reverse a string                                 |
| [RIGHT()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_right)                | Return the rightmost characters from a string    |
| [RPAD()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_rpad)                | Right-pad a string                                |
| [RTRIM()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_rtrim)              | Remove trailing spaces from a string             |
| [SOUNDEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_soundex)          | Return a soundex string                          |
| [SPACE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_space)                | Return a string consisting of the specified number of spaces |
| [STRCMP()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_strcmp)            | Compare two strings                              |
| [SUBSTRING()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_substring)      | Return a substring from a string                 |
| [SUBSTRING\_INDEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_substring-index) | Return a substring from a string before the first occurrence of a delimiter |
| [TRIM()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_trim)                | Remove leading and trailing spaces from a string  |
| [UCASE()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_ucase)              | Convert a string to uppercase                    |
| [UNHEX()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_unhex)              | Convert a hexadecimal string to a binary string   |
| [UPPER()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_upper)              | Synonym for UCASE()                               |
| [WEIGHT\_STRING()](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_weight-string) | Return the weight string for a string           |

### Date and Time Functions

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [ADDDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_adddate)    | Add a date value and an interval                  |
| [ADDTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_addtime)    | Add a time value and an interval                  |
| [CONVERT\_TZ()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_convert-tz) | Convert a datetime from one time zone to another |
| [CURDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_curdate)    | Return the current date                           |
| [CURRENT\_DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_current-date) | Synonym for CURDATE()                   |
| [CURRENT\_TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_current-time) | Return the current time                           |
| [CURRENT\_TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_current-timestamp) | Return the current date and time       |
| [CURTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_curtime)    | Return the current time                           |
| [DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date)          | Extract the date part of a datetime expression    |
| [DATE\_ADD()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-add)  | Add an interval to a date                        |
| [DATE\_FORMAT()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format) | Format a date value                     |
| [DATE\_SUB()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-sub)  | Subtract an interval from a date                |
| [DATEDIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_datediff)  | Subtract two dates and return the difference in days |
| [DAY()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_day)            | Extract the day of the month from a date          |
| [DAYNAME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayname)    | Return the name of the weekday                   |
| [DAYOFMONTH()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayofmonth) | Synonym for DAY()                    |
| [DAYOFWEEK()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayofweek) | Return the index of the weekday (1 = Sunday, 7 = Saturday) |
| [DAYOFYEAR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_dayofyear) | Return the day of the year                       |
| [EXTRACT()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_extract)    | Extract a part from a datetime expression        |
| [FROM\_DAYS()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_from-days) | Convert a day number to a date                   |
| [HOUR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_hour)          | Extract the hour from a time                     |
| [LAST\_DAY()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_last-day) | Return the last day of the month                 |
| [LOCALTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_localtime) | Synonym for NOW()                      |
| [LOCALTIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_localtimestamp) | Synonym for NOW()                  |
| [MAKEDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_makedate)  | Create a date from the year and day of year       |
| [MAKETIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_maketime)  | Create a time from the hour, minute, and second   |
| [MICROSECOND()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_microsecond) | Extract the microseconds from a time value    |
| [MINUTE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_minute)      | Extract the minute from a time                   |
| [MONTH()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_month)        | Extract the month from a date                    |
| [MONTHNAME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_monthname) | Return the name of the month                     |
| [NOW()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_now)            | Return the current date and time                 |
| [PERIOD\_ADD()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_period-add) | Add a period to a year-month value            |
| [PERIOD\_DIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_period-diff) | Subtract two period values and return the difference |
| [QUARTER()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_quarter)    | Return the quarter of the year                   |
| [SEC\_TO\_TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_sec-to-time) | Convert seconds to a time value           |
| [SECOND()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_second)      | Extract the second from a time                   |
| [STR\_TO\_DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_str-to-date) | Convert a string to a date value         |
| [SUBDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_subdate)    | Synonym for DATE\_SUB()                |
| [SUBTIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_subtime)    | Subtract a time value and an interval              |
| [SYSDATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_sysdate)    | Synonym for NOW()                    |
| [TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_time)          | Extract the time part of a datetime expression    |
| [TIME\_TO\_SEC()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_time-to-sec) | Convert a time value to seconds         |
| [TIMEDIFF()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timediff)  | Subtract two time values and return the difference |
| [TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestamp) | Convert a date and time to a timestamp           |
| [TO\_DAYS()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_to-days)    | Convert a date to a day number                   |
| [TO\_SECONDS()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_to-seconds) | Convert a date and time to seconds           |
| [UNIX\_TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_unix-timestamp) | Return a Unix timestamp             |
| [UTC\_DATE()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_utc-date)  | Return the current UTC date                      |
| [UTC\_TIME()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_utc-time)  | Return the current UTC time                      |
| [UTC\_TIMESTAMP()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_utc-timestamp) | Return the current UTC date and time  |
| [WEEK()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_week)          | Return the week number for a date                |
| [WEEKDAY()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_weekday)    | Return the index of the weekday (0 = Monday, 6 = Sunday) |
| [WEEKOFYEAR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_weekofyear) | Synonym for WEEK()                  |
| [YEAR()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_year)          | Extract the year from a date                      |
| [YEARWEEK()](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_yearweek)  | Return the year and week number for a date        |

### JSON Functions

| Function                                              | Description                                      |
|-------------------------------------------------------|--------------------------------------------------|
| [JSON\_ARRAY()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-array) | Create a JSON array               |
| [JSON\_ARRAYAGG()](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_json-arrayagg) | Aggregate values into a JSON array |
| [JSON\_CONTAINS()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-contains) | Check if a JSON document contains a specific value |
| [JSON\_CONTAINS\_PATH()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-contains-path) | Check if a JSON document contains a specific path |
| [JSON\_EXTRACT()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-extract) | Extract a value from a JSON document              |
| [JSON\_INSERT()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-insert) | Insert a value into a JSON document               |
| [JSON\_MERGE()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-merge) | Merge two or more JSON documents                  |
| [JSON\_MERGE\_PATCH()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-merge-patch) | Merge a JSON patch into a JSON document     |
| [JSON\_OBJECT()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-object) | Create a JSON object              |
| [JSON\_QUOTE()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-quote) | Quote a JSON string                           |
| [JSON\_REMOVE()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-remove) | Remove a value from a JSON document              |
| [JSON\_REPLACE()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-replace) | Replace a value in a JSON document                |
| [JSON\_SEARCH()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-search) | Search for a value in a JSON document             |
| [JSON\_SET()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-set) | Set a value in a JSON document                   |
| [JSON\_TYPE()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-type) | Return the JSON type of a value                |
| [JSON\_UNQUOTE()](https://dev.mysql.com/doc/refman/8.0/en/json-modification-functions.html#function_json-unquote) | Unquote a JSON string                         |

## Also see

* [Regex in MySQL](./regex#regex-in-mysql)

