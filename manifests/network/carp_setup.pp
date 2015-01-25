class freebsd::network::carp_setup {

  # add carp_load="YES" to /boot/loader.conf
  file_line { 'carp_load_line':
    path => '/boot/loader.conf',
    line => 'carp_load="YES"',
  }

  # load carp so we don't have to reboot
  exec { 'load_carp':
    command => '/sbin/kldload carp',
    unless  => '/sbin/kldstat -n carp.ko',
  }
}
