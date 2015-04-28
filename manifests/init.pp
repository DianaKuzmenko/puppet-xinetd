# Class: xinetd
#
# This class installs the xinetd package and enables the main xinetd service.
#
# It isn't meant to be used on its own, as it is automatically included by the
# more specific service related definitions of the module.
#
# Sample Usage :
#   include '::xinetd'
#
class xinetd (
  $package = $::xinetd::params::package,
) inherits ::xinetd::params {

  package { $package: ensure => installed }

  # On RHEL5 "xinetd is stopped" has an exit status of 0, on RHEL6 it's fixed
  if $::operatingsystem == 'RedHat'
  and versioncmp($::operatingsystemrelease, '6') < 0 {
    $hasstatus = false
  } else {
    $hasstatus = true
  }

  service { 'xinetd':
    ensure    => running,
    enable    => true,
    restart   => '/etc/init.d/xinetd reload',
    hasstatus => $hasstatus,
    require   => Package[$package],
  }

}

