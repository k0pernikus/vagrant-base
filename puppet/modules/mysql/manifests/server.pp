class mysql::server(
  $client_ip = '192.168.56.101'
) {
  package { 'mysql-server':
    ensure => present,
  }
  ->
  service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Package['mysql-server'],
  }

  file { '/etc/mysql/conf.d/my_puppet.cnf':
    ensure  => present,
    replace => true,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/my.cnf"),
    require => Package['mysql-server'],
    notify  => Service['mysql']
  }

  package { 'mytop':
    ensure => present,
  }

  # @TODO onlyif does not work currently: workaround with "creates"
  if $client_ip {
    exec { "allow db access from $client_ip":
      name    => "echo \"GRANT ALL ON *.* to root@'${client_ip}' IDENTIFIED BY ''; FLUSH PRIVILEGES; \"|mysql -h localhost -D mysql -u root --password=\"\" > /tmp/mysql_grant.log 2>&1",
      path    => ['/bin', '/usr/bin'],
      creates => '/tmp/mysql_grant.log',
      # onlyif => "echo \"SHOW GRANTS for root@'${client_ip}'\" | mysql -h localhost -D mysql -u root --password=\"\" | grep ERROR",
      require => Service['mysql']
    }
  }
}
