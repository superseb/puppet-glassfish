# Class: glassfish::path
#
# Manages adding Glassfish to the path.
#
class glassfish::path {
  case $::osfamily {
    'RedHat' : {
      # Add a file to the profile.d directory
      file { '/etc/profile.d/glassfish.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('glassfish/glassfish-profile-el.erb'),
        require => Class['glassfish::install']
      }
    }
    'Debian' : {
      fail('Debian doesn\'t support profile.d, so can\'t add to path.')
    }
    default  : {
      fail("OSFamily ${::osfamily} is not currently supported.")
    }
  }

}
