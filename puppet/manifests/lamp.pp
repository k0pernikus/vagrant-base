$composer_dir = '/usr/local/bin'

notify { "!!! HAPPY PROVISIONING (LAMP) !!!": }
->
  package {
    [
      'curl',
      'git-core',
      'vim',
      'tree',
    ]:
    ensure => present,
  }
->
class { 'php5':
  php_package => 'libapache2-mod-php5',
  service     => 'apache2'
}
->
class { 'composer':
  dir => $composer_dir
}
->
class { 'apache2':
}
->
apache2::vhost { 'workshop.dev':
  priority      => 20,
  document_root => '/vagrant/symfony/web',
  index_file    => 'app_dev.php'
}
->
class { 'apache2::service': }
->
file { '/var/www':
  ensure  => directory,
  replace => true,
  owner   => vagrant,
  group   => vagrant,
}
->
class { 'mysql::server': }
class { 'ntp': }
