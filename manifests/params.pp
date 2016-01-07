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
          $package_name = 'python3-borgbackup'
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
