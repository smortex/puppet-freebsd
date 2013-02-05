class freebsd::src (
  $dir     = '/usr/src',
  $release = '9.1.0',
) {

  # The following should probably be broken up into a define(s), but we are
  # only working with amd64 and 9.0 boxes for now, so I am not too worried.

  package { "devel/subversion": }

  exec { "checkout source":
    command => "/usr/local/bin/svn co svn://svn.freebsd.org/base/release/${release}/ ${dir}/",
    creates => "${dir}/.svn",
    timeout => '1800',
    require => Package["devel/subversion"],
  }

  freebsd::kernel {
    "firewall":
  }

  file_line { 'set option ipsec':
    path    => '/root/kernels/FIREWALL',
    line    => 'options IPSEC',
    require => Exec["copy generic kernel to firewall"],
  }

  file_line { 'set device crypto':
    path    => '/root/kernels/FIREWALL',
    line    => 'device crypto  # needed to compile IPSEC support.',
    require => Exec["copy generic kernel to firewall"],
  }

  file_line { 'set device pf':
    path    => '/root/kernels/FIREWALL',
    line    => 'device pf',
    require => Exec["copy generic kernel to firewall"],
  }

  file_line { 'set device pflog':
    path    => '/root/kernels/FIREWALL',
    line    => 'device pflog',
    require => Exec["copy generic kernel to firewall"],
  }

  file_line { 'set device pfsync':
    path    => '/root/kernels/FIREWALL',
    line    => 'device pfsync',
    require => Exec["copy generic kernel to firewall"],
  }
}
