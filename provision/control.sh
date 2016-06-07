#Quito interactividad
export DEBIAN_FRONTEND=noninteractive

#Usuario respaldo
useradd -m respaldo
echo respaldo:password | chpasswd

#Certificado
mkdir /home/respaldo/.ssh
cp /vagrant/provision/keys/id_rsa /vagrant/provision/keys/id_rsa.pub /home/respaldo/.ssh
#cp /vagrant/provision/keys/known_hosts /home/respaldo/.ssh
chown -R respaldo:respaldo /home/respaldo/.ssh
chmod 700 /home/respaldo/.ssh
chmod 600 /home/respaldo/.ssh/id_rsa
chmod 644 /home/respaldo/.ssh/id_rsa.pub

#Usuario operador
useradd -m operador
echo operador:password | chpasswd
usermod -aG sudo operador

#Hosts por nombre
cat /vagrant/provision/configs/hosts_control >> /etc/hosts