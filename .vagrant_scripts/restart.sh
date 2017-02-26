echo "Initializing restart.sh"

echo "Going to ensure that vagrant owns everything prior to shutdown"

chown -R vagrant:vagrant /home/vagrant

echo "Preparing to restart the vagrant box"

reboot
