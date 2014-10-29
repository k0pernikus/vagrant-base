define apache2::vhost(
    $priority      = '50',
    $document_root = '/var/www',
    $server_name   = $name,
    $index_file    = $name
) {

  include apache2

  file { "/etc/apache2/sites-available/${priority}-${name}.conf":
    ensure   => file,
    replace  => true,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template("${module_name}/vhost.erb"),
    require  => Package['apache2'],
    notify   => Service['apache2'],
  }
  ->
  exec { "/usr/sbin/a2ensite ${priority}-${name}.conf":
  }
}
