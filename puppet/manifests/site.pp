node "wordpress.heartofamericait.com" { 
  include apache

  class { 'wordpress':
    install_url => 'http://www.wordpress.org/wordpress-3.8.tar.gz',
  }
}
