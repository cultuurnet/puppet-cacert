# == Class cacert::params
#
# This class is meant to be called from cacert.
# It sets variables according to platform.
#
class cacert::params {
  case $::operatingsystem {
    'Ubuntu': {
      case $::operatingsystemrelease {
        '14.04': {
          $certificate_rootdir = '/usr/local/share/ca-certificates'
        }
        default: {
          fail("Ubuntu ${::operatingsystemrelease} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
