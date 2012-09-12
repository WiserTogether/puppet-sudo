define sudo::directive (
  $ensure=present,
  $content="",
  $source=""
) {
  require sudo::params

  # sudo skipping file names that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  if $sudo_use_single_file {

    common::concatfilepart {$dname:
      ensure => $ensure,
      manage => true,
      file => "/etc/sudoers",
      content => $content ? {
        ""      => undef,
        default => "$content\n",
      },
      source => $source ? {
        ""      => undef,
        default => $source,
      },
      require => $sudo_package,
    }
  
  } else {

    file {"/etc/sudoers.d/${dname}":
      ensure  => $ensure,
      owner   => root,
      mode    => 0440,
      content => $content ? {
        ""      => undef,   
        default => "$content\n",
      },
      source  => $source ? {
        ""      => undef,  
        default => $source,
      },
      notify  => Exec["sudo-syntax-check for file $dname"],
      require => $sudo_package,
    }
  
  }

  exec {"sudo-syntax-check for file $dname":
    command     => "visudo -c -f /etc/sudoers.d/${dname} || ( rm -f /etc/sudoers.d/${dname} && exit 1)",
    refreshonly => true,
  }

}
