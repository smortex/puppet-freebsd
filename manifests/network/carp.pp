define freebsd::network::carp (
  $password      = '',
  $advbase       = '',
  $advskew       = '',
  $vhid,
  $address         # CIDR
  $do_carp_setup = false,
) {

  # if do_carp_setup is true, add carp_load="YES" to /bood/loader.conf
  # and run kldload carp
  if $do_carp_setup {
    include carp_setup
  }

  # The following adds teh necessary configuration for a carp interface to
  # rc.conf.  Eventually this could manage the interface creation and
  # destruction.

  # munge the password string for use in the $carp_string if we have set one
  if ( $password != '') {
    $password_string = " pass ${password}"
  } else {
    $password_string = ""
  }

  # munge the advbase string for use in the $carp_string if we have set one
  if ( $advbase != '') {
    $advbase_string = " advbase ${advbase}"
  } else {
    $advbase_string = ""
  }

  # munge the advskew string for use in the $carp_string if we have set one
  if ( $advskew != '') {
    $advskew_string = " advskew ${advskew}"
  } else {
    $advskew_string = ""
  }

  # Build the carp configuration here for simplicity
  $carp_string = "vhid ${vhid}${password_string}${advbase_string}${advskew_string} ${address}"

  # Add the ifconfig line to rc.conf
  shell_config { "configure_carp_${name}":
    file  => '/etc/rc.conf',
    key   => "ifconfig_${name}",
    value => "${carp_string}"
  }
}
