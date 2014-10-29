class apache2(
){
  package { 'apache2':
    ensure => present,
  }
  ->
  file { "/etc/apache2/sites-enabled/000-default":
    ensure   => absent,
  }
  ->
  file { "/etc/apache2/sites-enabled/000-default.conf":
    ensure   => absent,
  }
  ->
  apache2::mod { 'rewrite': }
}

