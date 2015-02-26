#Puppet Master Install
# http://docs.puppetlabs.com/guides/installation.html#red-hat-enterprise-linux-and-derivatives
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

# Set the hostname to puppet
# sudo vim /etc/sysconfig/network
sudo hostname wordpress.heartofamericait.com
sudo service network restart

# ensure the date/time is synced
sudo ntpdate us.pool.ntp.org

# shut down firewall permanently
sudo service iptables save
sudo service iptables stop
sudo chkconfig iptables off

# add the RPM
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-red-hat-enterprise-linux-and-derivatives
sudo yum -y install puppetlabs-release
sudo yum -y install puppet

# Add puppetmaster to hosts file
sudo echo "192.168.0.6     puppetmaster.heartofamericait.com puppetmaster" >> /etc/hosts

# Add puppetmaster to puppet.conf
sudo sed -i '/\[main\]/a      server = puppetmaster.heartofamericait.com' /etc/puppet/puppet.conf
sudo sed -i 's/server =/    server =/' /etc/puppet/puppet.conf
sudo sed -i '/localconfig =/a      runinterval = 120' /etc/puppet/puppet.conf
sudo sed -i '/localconfig =/a      debug = true' /etc/puppet/puppet.conf

# http://docs.puppetlabs.com/guides/installation.html#post-install
sudo puppet resource service puppet ensure=running enable=true

# Request cert 
sudo puppet agent --waitforcert 60 --test 

# set vagrant password
usermod -p "paX5EmO4EXy0I" vagrant



