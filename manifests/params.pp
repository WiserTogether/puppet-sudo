class sudo::params {
  if $::operatingsystem == 'darwin' {
     $sudo_admin_group = true
  }

  case $::fqdn {
    /vagrantup.com/: {
        $sudo_nopasswd_admin_group = true
    }
  }

  $sudo_package = $::operatingsystem ? {
    darwin =>  undef,
    default => Package['sudo'],
  }

  $sudo_use_single_file = versioncmp($sudoversion,'1.7.2') < 0

}
