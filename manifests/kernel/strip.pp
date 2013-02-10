class freebsd::kernel::strip (
  $src_dir  = '/usr/src',
  $conf_dir = '/root/kernels',
){

  include freebsd::src

  file { $conf_dir:
    ensure => directory,
  }

  exec { "strip_generic_kernel_of_its_identity":
    command => "/usr/bin/grep -v ident ${src_dir}/sys/amd64/conf/GENERIC > ${conf_dir}/GENERIC.stripped",
    require => File[$conf_dir],
    creates => "${conf_dir}/GENERIC.stripped",
  }
}
