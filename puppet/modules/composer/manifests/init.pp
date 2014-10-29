class composer(
  $dir  = '/usr/local/bin'
) {
  exec { 'composer_install':
    name    => 'curl -s getcomposer.org/installer | php',
    cwd     => $dir,
    creates => '/usr/local/bin/composer.phar',
    path    => '/usr/bin'
  }
  ->
  exec { 'composer_permissions':
    name  => 'chmod 777 composer.phar',
    cwd   => $dir,
    path  => '/bin'
  }
  ->
  exec { 'composer_link':
    name    => 'ln -s composer.phar composer',
    cwd     => $dir,
    creates => '/usr/local/bin/composer',
    path    => '/bin'
  }
}
