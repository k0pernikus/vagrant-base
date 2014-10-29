$composer_dir = '/usr/local/bin'

notify { "!!! HAPPY PROVISIONING (LNMP) !!!": }
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
  with_fpm => true,
}
->
class { 'composer':
  dir => $composer_dir
}
->
class { 'nginx':
  server_name   => 'workshop.dev',
  document_root => '/vagrant/symfony/web',
  index_file    => 'app_dev.php',
}
->
file { '/var/www':
  ensure  => directory,
  replace => true,
  owner   => vagrant,
  group   => vagrant,
}
->
class { 'mysql::server': }


