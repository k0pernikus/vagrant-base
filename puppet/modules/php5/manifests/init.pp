class php5(
  $with_fpm         = false,

  # template vars
  $memory_limit     = '768M',
  $error_reporting  = 'E_ALL',
  $apc_stat         = 1,
  $display_errors   = false,
  $xdebug_max_nesting_level = 250,
  $service          = 'php5-fpm',
  $php_package      = 'php5-fpm'
){

  package {
    [
      $php_package,
      'php5-cli',
      'php5-curl',
      'php5-intl',
      'php5-mysql',
      'php5-sqlite',
      'php5-dev',
    ]:
    ensure => present,
  }

  # additional files needed with PHP 5.5
  package {
    [
      'php5-json',
    ]:
    ensure => present,
    require => Package[$php_package]
  }

  if $with_fpm {
    $config_file = '/etc/php5/fpm/conf.d/zzz_project.ini'
  } else {
    $config_file = '/etc/php5/apache2/conf.d/zzz_project.ini'
  }

  file { '/etc/php5/cli/conf.d/zzz_project.ini':
    ensure  => file,
    replace => true,
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/php.ini.erb"),
    require => [Package[$php_package], Package['php5-cli']],
    notify  => Service[$service]
  }

  file { $config_file:
    ensure  => file,
    replace => true,
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/php.ini.erb"),
    require => Package[$php_package],
    notify  => Service[$service]
  }


  if $with_fpm {
    service { 'php5-fpm':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => File[$config_file],
    }
  }
}
