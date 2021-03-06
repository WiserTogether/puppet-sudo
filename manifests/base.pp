class sudo::base inherits sudo::params {
  if $::operatingsystem != 'darwin' {
    package { 'sudo': 
      ensure => "present",
    }
  }

  file {"/etc/sudoers":
    ensure => present,
    owner  => root,
    mode   => 440,
  }

  if $sudo_use_single_file {
    #
    # Backward compatibility for version less than 1.7.2
    # 
    common::concatfilepart { "000-sudoers.init":
      ensure  => present,
      manage  => true,
      file    => "/etc/sudoers",
      content => template("sudo/sudoers.erb"),
    }
   
  } else {
    #
    # Use the #includedir directive to manage sudoers.d, version >= 1.7.2
    # 
    file {"/etc/sudoers.d":
      ensure  => directory,
      owner   => root,
      mode    => 755,
      purge   => true,
      recurse => true,
    }

    File ["/etc/sudoers"] { content => template("sudo/sudoers.erb"), }

  }

}
