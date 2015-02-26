#Puppet Master Install
# http://docs.puppetlabs.com/guides/installation.html#red-hat-enterprise-linux-and-derivatives
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

# ensure the date/time is synced
sudo ntpdate us.pool.ntp.org

# Set up NTPD
sudo service ntpd start

# shut down firewall permanently
sudo service iptables save
sudo service iptables stop
sudo chkconfig iptables off

# Set the hostname to puppet
# sudo vim /etc/sysconfig/network
sudo hostname puppetmaster.heartofamericait.com
sudo service network restart


# add the RPM
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-red-hat-enterprise-linux-and-derivatives
sudo yum -y install puppet-release
sudo yum -y install puppet-server

# autosign on - never use this for production
sudo sh -c "echo *.localdomain" > /etc/puppet/autosign.conf
sudo sh -c "echo *.heartofamericait.com" >> /etc/puppet/autosign.conf

sudo service puppet stop
sudo service puppetmaster stop

#move puppet.conf into place
sudo cp /home/vagrant/puppet/puppet.conf /etc/puppet/puppet.conf

#start puppetmaster
sudo service puppetmaster start
sudo service puppet start

# http://docs.puppetlabs.com/guides/installation.html#post-install
sudo puppet resource service puppet ensure=running enable=true
sudo puppet resource service puppetmaster ensure=running enable=true

# set vagrant password
usermod -p "paX5EmO4EXy0I" vagrant

# restart seemed necessary after foreman install.  may not be needed here
sudo service puppetmaster restart

# add puppet-module functionality - suspect this is antiquated
#sudo gem install puppet-module

# add puppetforge module
sudo puppet module install hunner/wordpress


# add wordpress definition in sites.pp
sudo echo 'node "wordpress.heartofamericait.com" { ' >> /etc/puppet/manifests/site.pp
sudo echo '  include wordpress' >> /etc/puppet/manifests/site.pp
sudo echo '}' >> /etc/puppet/manifests/site.pp
