# Class: xinetd::params
#
class xinetd::params {

  case $::operatingsystem {
    'Gentoo': {
      $package = 'sys-apps/xinetd'
    }
    default: {
      $package = 'xinetd'
    }
  }

}

