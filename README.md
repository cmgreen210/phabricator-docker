## Initial Setup
### Docker Containers
```bash
# MySQL Docker Container
sudo mkdir -p /storage/docker/mysql/phabricator
docker run \
  --detach \
  --name mysql-phab \
  --env="MYSQL_ROOT_PASSWORD={YOUR_PASSWORD}" \
  --volume="/storage/docker/mysql/phabricator:/var/lib/mysql" \
  mysql
  
# Phabricator Docker Container
docker build -t phab .
docker run \
  -p 80:80 \
  --detach \
  --name phab \
  --link mysql-phab \
  phab
```
### Phabricator Configuration
```bash
docker exec -it phab bash
# Running in container now
cd /opt/phabricator
./bin/config set mysql.user root
./bin/config set mysql.pass {YOUR_PASSWORD}
./bin/config set mysql.host $(cat /etc/hosts | grep -i mysql | awk '{ print $1 }')
./bin/config set mysql.port 3306
./bin/storage upgrade --force # takes a little while
```
Navigate to http://127.0.0.1.

