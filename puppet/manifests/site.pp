node "wordpress.heartofamericait.com" { 
  include apache
  include '::mysql::server'

  class { 'wordpress':
    install_url => 'http://www.wordpress.org',
  }
}
