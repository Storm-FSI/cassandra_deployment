#!/bin/bash
sudo yum install java-1.8.0-openjdk -y
echo "export PATH=/usr/bin/java:$PATH" >> ~/.bashrc

cat <<EOF | sudo tee -a /etc/yum.repos.d/cassandra40x.repo
[cassandra]
name=Apache Cassandra
baseurl=https://redhat.cassandra.apache.org/40x/noboolean
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF

# create /data directory
sudo mkdir -p /data/
sudo mkdir -p /data/cassandra
sudo mkdir -p /data/cassandra/data
sudo mkdir -p /data/cassandra/commitlog
sudo mkdir -p /data/cassandra/data/commitlog
sudo mkdir -p /data/cassandra/saved_caches
sudo mkdir -p /data/cassandra/commit_log_backup
sudo mkdir -p /data/cassandra/hints

# add history date to bashrc
cat >>~/.bashrc <<EOF
export HISTTIMEFORMAT="%d/%m/%y %T "
export PYTHONPATH=/usr/lib/python3.6/site-packages/
EOF

sudo yum update -y

sudo yum install cassandra -y
sudo systemctl daemon-reload
sudo service cassandra stop

# clear out data
sudo rm -rf /var/lib/cassandra/data/system/*

sudo tee -a /etc/sysctl.conf >/dev/null <<EOT
net.ipv4.tcp_keepalive_time=60
net.ipv4.tcp_keepalive_probes=3
net.ipv4.tcp_keepalive_intvl=10
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.core.rmem_default=16777216
net.core.wmem_default=16777216
net.core.optmem_max=40960
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_wmem=4096 65536 16777216
EOT

sudo sysctl -p

sudo tee -a /etc/security/limits.conf >/dev/null <<EOF
cassandra - memlock unlimited
cassandra - nofile 100000
cassandra - nproc 32768
cassandra - as unlimited
* hard    nofile  65532
* soft    nofile  65532
root - memlock unlimited
root - nofile 100000
root - nproc 32768
root - as unlimited
EOF

ulimit -n -H

sudo tee -a /etc/cassandra/conf/cassandra-env.sh >/dev/null <<EOF
JVM_OPTS="\$JVM_OPTS -Dcassandra.consistent.rangemovement=false"
EOF

sudo tee /etc/environment >/dev/null <<EOF
PYTHONPATH="/usr/lib/python3.6/site-packages/"
EOF

# Ensures dir exists
sudo mkdir -p /opt/ncso/var/lib/mft
sudo mkdir -p /tmp/scripts
sudo mkdir -p /root/.cassandra

sudo chown -R cassandra /data

# provide 755 to /usr/sbin
sudo chmod 755 /usr/sbin

# backup logging file and clean
current=$(date "+%Y.%m.%d-%H.%M.%S")
if [ -f /var/log/cassandra/system.log ]; then
  sudo mv /var/log/cassandra/system.log /var/log/cassandra/system."$current".log
fi

# make cassandra service
sudo mv /etc/rc.d/init.d/cassandra /etc/rc.d/init.d/cassandra.old

# generate service
sudo cp /tmp/cassandra.service /etc/systemd/system/cassandra.service

# make cassandra service
sudo systemctl daemon-reload
