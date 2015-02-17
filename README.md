# A Puppet module for managing FreeBSD

This module is a compilation of types and facts that make working with FreeBSD a joy.

    NOTE: This module is not much maintained anymore, and I'm considering it
    deprecated.  BSD efforts are moving to a more general BSD module located
    here:

[xaque208/puppet-bsd](https://github.com/xaque208/puppet-bsd)

    Please direct efforts/issues/pull requests toward the BSD module instead of
    to the FreeBSD module.

## Classes

### freebsd::login

Manages the `/etc/login.conf` file.  By default, including this class will
mange the file using the defaults that ship with 9.1-REL.  The knobs in the
default login class have been exposed as parameters to the class, and only
tuning the default class is currently supported.

### freebsd::kernel

Manages kernel configuration files for easy custom kernel building.  This is
handy if you maintain a set of different builds in your environment.  Intended
to be used on a central build host.


### freebsd::network

Configures some base network parameters.  Useful for machines that have
specific networking needs such as routers and firewalls.

## Types

### freebsd::src

Manages checkout of the FreeBSD kernel source using subversion.

### freebsd::network::carp

Builds the rc.conf configuration necessary to enable CARP interfaces.  Does not
bring the interface online.

### freebsd::network::interface

Configures rc.conf for a given interface.

### freebsd::network::lagg

Configures rc.conf for a given LAGG interface.

### freebsd::network::vlan

Configures rc.conf for a given VLAN interface and brings the interface up.

