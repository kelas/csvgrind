#Installation
```bash
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.listd
sudo apt update
sudo apt-get postgresql-13
sudo apt install timescaledb-2-loader-postgresql-13
sudo apt install timescaledb-2-postgresql-13

```
#Settings
```bash
sudo timescaledb-tune
sudo service postgresql restart
sudo -u postgres psql
\c
CREATE EXTENSION IF NOT EXISTS timescaledb;

```
