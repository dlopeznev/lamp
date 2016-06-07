#Quito interactividad
export DEBIAN_FRONTEND=noninteractive

#Certificado
mkdir /root/.ssh
cat /vagrant/provision/keys/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

#Usuario operador
useradd -m operador
echo operador:password | chpasswd
usermod -aG sudo operador

#SSH puerto 4000
cp -f /vagrant/provision/configs/sshd_config /etc/ssh/
systemctl restart sshd

#MySQL
apt-get update -q -y
apt-get -q -y install mysql-server
mysqladmin -u root password root

#Configuracion bdd
cp -f /vagrant/provision/db/my.cnf /etc/mysql/

#Mysql no password prompt
cp -f /vagrant/provision/configs/.my.cnf /root/

#Restart bdd
systemctl restart mysql

#Restore bdd dump
mysql -u root < /vagrant/provision/db/db.dmp

#Grant privileges
mysql -u root < /vagrant/provision/db/grants

#Restart bdd
systemctl restart mysql

#Hosts por nombre
cat /vagrant/provision/configs/hosts_datos >> /etc/hosts