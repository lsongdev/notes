---
layout: default
title: SQLite
---

# SQLite


## Install 

```shell
wget https://www.sqlite.org/2023/sqlite-autoconf-3410200.tar.gz
tar -xzf sqlite-autoconf-3410200.tar.gz
cd sqlite-autoconf-3410200
./configure
make
sudo make install
```

```shell 
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/sqlite3.conf
sudo ldconfig
```

## Show tables

```sql
.tables
```
