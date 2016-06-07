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

#Apache
apt-get update -q -y
apt-get -q -y install apache2 mysql-client php5 php5-mysql php5-curl php5-gd

#Paginas base
cp /vagrant/provision/www/*.* /var/www/html

#Link Wordpress
ln -s /vagrant/provision/wordpress /var/www/html
chmod -R 755 /var/www/html/wordpress

#Restart Apache
systemctl restart apache2

#Hosts por nombre
cat /vagrant/provision/configs/hosts_server >> /etc/hosts