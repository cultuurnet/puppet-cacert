# Class: cacert
class cacert inherits ::cacert::params {

  file { "${certificate_rootdir}/cacert.org":
    ensure => directory
  }

  # Originally from http://www.cacert.org/certs/root.crt
  file { "${certificate_rootdir}/cacert.org/root.crt":
    ensure => 'file',
    source => "puppet://${server}/modules/cacert/root.crt",
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    notify => Exec['CAcert update-ca-certificates']
  }

  # Originally from http://www.cacert.org/certs/class3.crt
  file { "${certificate_rootdir}/cacert.org/class3.crt":
    ensure => 'file',
    source => "puppet://${server}/modules/cacert/class3.crt",
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    notify => Exec['CAcert update-ca-certificates']
  }

  exec { 'CAcert update-ca-certificates':
    command     => 'update-ca-certificates',
    refreshonly => true
  }
}
