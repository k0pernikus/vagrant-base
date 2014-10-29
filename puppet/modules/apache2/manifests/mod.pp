define apache2::mod() {

  include apache2

  exec { "a2enmod ${name}":
    path => ['/usr/bin', '/usr/sbin'],
  }

}
