# Class: cacert
class cacert inherits ::cacert::params {

  include wget

  file { '/usr/local/share/ca-certificates/cacert.org':
    ensure => directory
  }

  wget::fetch { 'http://www.cacert.org/certs/root.crt':
    destination => '/usr/local/share/ca-certificates/cacert.org/root.crt',
    timeout     => 5,
    verbose     => false,
    notify      => Exec['CAcert update-ca-certificates'],
    tag         => 'cacert'
  }

  wget::fetch { 'http://www.cacert.org/certs/class3.crt':
    destination => '/usr/local/share/ca-certificates/cacert.org/class3.crt',
    timeout     => 5,
    verbose     => false,
    notify      => Exec['CAcert update-ca-certificates'],
    tag         => 'cacert'
  }

  exec { 'CAcert update-ca-certificates':
    command     => 'update-ca-certificates',
    refreshonly => true
  }

  Class['wget'] -> File['/usr/local/share/ca-certificates/cacert.org'] -> Wget::Fetch <| tag == 'cacert' |> -> Exec['CAcert update-ca-certificates']
}
