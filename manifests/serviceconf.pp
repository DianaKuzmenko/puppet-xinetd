# Define: xinetd::serviceconf
#
# Create full configuration for new xinetd-based services.
#
# Parameters control the service options as documented in xinetd.conf(5).
#
# Sample Usage :
# * Create and enable a new service for vmstat output :
#    xinetd::serviceconf { 'vmstat':
#      service_type => 'UNLISTED',
#      port         => '24101',
#      user         => 'nobody',
#      server       => '/usr/bin/vmstat',
#    }
# * Remove the above service :
#    xinetd::serviceconf { 'vmstat':
#      ensure => absent,
#    }
#
define xinetd::serviceconf (
  $ensure         = 'present',
  # $id and $type are reserved puppet variables it seems...
  $service_id     = undef,
  $service_type   = undef,
  $flags          = undef,
  $disable        = 'no',
  $socket_type    = 'stream',
  $protocol       = 'tcp',
  $wait           = 'no',
  $user           = 'root',
  $group          = undef,
  $instances      = undef,
  $nice           = undef,
  $server         = undef,
  $server_args    = undef,
  $only_from      = undef,
  $no_access      = undef,
  $access_times   = undef,
  $log_type       = undef,
  $log_on_success = undef,
  $log_on_failure = undef,
  $rpc_version    = undef,
  $rpc_number     = undef,
  $env            = undef,
  $passenv        = undef,
  $port           = undef,
  $redirect       = undef,
  $bind           = undef,
  $banner         = undef,
  $banner_success = undef,
  $banner_fail    = undef,
  $per_source     = undef,
  $cps            = undef,
  $max_load       = undef,
  $groups         = undef,
  $mdns           = undef,
  $umask          = undef,
  $rlimit_as      = undef,
  $rlimit_files   = undef,
  $rlimit_cpu     = undef,
  $rlimit_data    = undef,
  $rlimit_rss     = undef,
  $rlimit_stack   = undef,
  $deny_time      = undef
) {

  $service_name = $title

  if $ensure == 'absent' {

    file { "/etc/xinetd.d/${service_name}":
      ensure => absent,
    }

    # We don't want to make xinetd mandatory for absent
    exec { '/etc/init.d/xinetd reload':
      subscribe   => File["/etc/xinetd.d/${service_name}"],
      refreshonly => true,
    }

  } else {

    include xinetd

    file { "/etc/xinetd.d/${service_name}":
      content => template('xinetd/xinetd.d-service.erb'),
      notify  => Service['xinetd'],
    }

  }

}

