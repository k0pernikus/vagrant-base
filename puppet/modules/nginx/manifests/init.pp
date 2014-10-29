class nginx(
  $document_root = '/var/www',
  $index_file    = 'index.php',
  $port          = 80,
  $server_name   = 'localhost'
){

  $php_socket = 'unix:/var/run/php5-fpm.sock'

  package { 'nginx':
    ensure => present,
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure   => file,
    replace  => true,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template("${module_name}/localhost.erb"),
    require  => Package['nginx'],
    notify   => Service['nginx'],
  }
}
