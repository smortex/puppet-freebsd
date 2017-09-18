# Class to manage the /etc/login.conf file on FreeBSD.
class freebsd::login (
  Hash[String, Hash[String, Variant[Boolean, String]]] $classes
) {

  file { '/etc/login.conf':
    path    => '/etc/login.conf',
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('freebsd/etc/login.conf.erb'),
    notify  => Exec['update_login_database'],
  }

  exec{ 'update_login_database':
    command     => '/usr/bin/cap_mkdb /etc/login.conf',
    refreshonly => true,
  }
}
