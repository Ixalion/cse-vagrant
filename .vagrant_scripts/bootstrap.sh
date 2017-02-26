echo "Initializing bootstrap.sh"

echo "Lets go and set up pacman, retrieving any new keys, and disablying the gpg check for community packages."
sed -i 's/\[community\]/# community removed/g' /etc/pacman.conf
echo "[community]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

pacman-key --init > /dev/null 2>&1
pacman-key --populate archlinux > /dev/null 2>&1
pacman-key --refresh-keys > /dev/null 2>&1

echo "Now we need to go and upgrade all of the repos and packages. "
pacman -Syu --noconfirm > /dev/null 2>&1

echo "If a mirrorlist was downloaded, lets use the new one."
# Update the mirror list (if a new one was downloaded)
mv -f -T /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist > /dev/null 2>&1

# Uncomment the Servers in mirrorlist
sed -i '/Server/s/^#//g' /etc/pacman.d/mirrorlist > /dev/null 2>&1


echo "Creating the shared directorys"
mkdir -p /home/vagrant/shared
mkdir -p /home/vagrant/grader_scripts

echo "Going to be installing Xorg now. "
pacman -S mesa-libgl xorg-server --noconfirm > /dev/null 2>&1

echo "Going to be installing the LXDE."
pacman -S lxde --noconfirm > /dev/null 2>&1

echo "Enablying LXDM on boot."
systemctl enable lxdm 2>&1


echo "Lets make the vagrant use auto-login when booting LXDM."
sed -i 's/# autologin=dgod/autologin=vagrant/g' /etc/lxdm/lxdm.conf > /dev/null 2>&1

echo "Lets go and upgrade the virtualbox guest additions. "
pacman -S --force --noconfirm virtualbox-guest-utils virtualbox-guest-modules-arch > /dev/null 2>&1

echo "We are now going to go and install cower -> pacaur from the AUR. "
# Download cower and pacaur PKGBUILDs.
mkdir -p /home/vagrant/cower
mkdir -p /home/vagrant/pacaur
curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower" > /home/vagrant/cower/PKGBUILD 2>/dev/null
curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur" > /home/vagrant/pacaur/PKGBUILD 2>/dev/null

# Take ownership of the directories.
chown vagrant:vagrant -R /home/vagrant > /dev/null 2>&1

# Install the yajl dependency
pacman -S yajl git expac --noconfirm > /dev/null 2>&1

# Build pacaur (and cower)
sudo -u vagrant bash -c "(cd /home/vagrant/cower; makepkg -i --noconfirm --skippgpcheck)" > /dev/null 2>&1
sudo -u vagrant bash -c "(cd /home/vagrant/pacaur; makepkg -i --noconfirm --skippgpcheck)" > /dev/null 2>&1

echo "Now that pacaur is setup, lets go and install jdk."
sudo -u vagrant pacaur -S jdk --noconfirm --noedit > /dev/null 2>&1

echo "Next up, is installing eclipse. (We will go and configure it later on.)"
pacman -S eclipse-java --noconfirm > /dev/null 2>&1

echo "We are now going to install a few more dependencies that will be used later on."
pacman -S wget --noconfirm > /dev/null 2>&1

echo "We are going to now install ruby onto the system."
pacman -S ruby --noconfirm > /dev/null 2>&1

echo "We are going to now install the Google Chrome browser onto the system."
sudo -u vagrant pacaur -S google-chrome --noconfirm --noedit > /dev/null 2>&1

echo "Finished bootstrap.sh"
