==================
Sudo Puppet module
==================

Since the version 1.7.2 a new `#includedir` directive is available in sudoers.                                                                                
To keep backward compatibility with old sudo versions the `common::concatfilepart` definition is used when the sudo
version is too old. A custom fact is included that executes sudo -V and uses version comparison to determine whether
to use concatfile or #include.  This behavior can be overwritten by setting params::sudo_use_single_file if necessary.

The definition `sudo::directive` provides a simple way to write sudo configurations parts. If you use a sudo
version >= 1.7.2, the sudo directive part is validated via visudo and removed if syntax is not correct.

------------------
Use
------------------

`directive`s are blocks of literal text as you would write to sudoers.

If you have a class of users named `users::virtual` and a virtual Group named `admin`:

::

  class sudo {
    include sudo::base
    include users::virtual

    realize(Group['admin'])

    sudo::directive {"admin_users":
      ensure => present,
      content => "%admin ALL=(ALL) ALL",
      require => Group['admin'],
    }
  }

------------------
About
------------------


This module is provided to you by Camptocamp_.

.. _Camptocamp: http://www.camptocamp.com/

For more information about sudo see http://www.gratisoft.us/sudo/

Depends on the `common` module available here: https://github.com/camptocamp/puppet-common
