class sudo::params {
  if $::operatingsystem == 'darwin' {
     $sudo_admin_group = true
  }

  case $::fqdn {
    /vagrantup.com/: {
        $sudo_nopasswd_admin_group = true
    }
  }

  $release_version = $operatingsystem ? {
    RedHat => $lsbdistcodename ? {
      /^Nahant.*/        => '1.6.7',
      /Tikanga|Santiago/ => '1.7.2',
    },
    Debian => $lsbdistcodename ? {
      lenny   => '1.6.9',
      squeeze => '1.7.4',
    },
    Ubuntu => $lsbdistcodename ? {
      lucid => '1.7.4p4-3',
    },
    CentOS => $lsbmajdistrelease ? {
      5 => '1.7.2',
      6 => '1.7.2p2',
    },
    default => $::sudoversion,
  }

  if !$sudo_version { 
    $version = "present" 
    $majversion = $release_version
  } else {
    $majversion = $sudo_version
    $version = $sudo_version
  }

  $sudo_package = $::operatingsystem ? {
    darwin =>  undef,
    default => Package['sudo'],
  }

  $sudo_use_single_file = versioncmp($sudoversion,'1.7.2') < 0

}
