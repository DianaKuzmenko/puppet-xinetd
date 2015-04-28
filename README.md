# puppet-xinetd

## Overview

Install, enable and manage xinetd. Manage existing services and configure new
ones as needed.

* `xinetd` : Main class to install and enable the xinetd service.
* `xinetd::service` : Definition to manage existing xinetd-based services.
* `xinetd::serviceconf` : Definition to create configuration for new services.

The `xinetd::service` definition is a very thin wrapper around puppet's
`service` type, and is here only for the sake of completeness.

## Examples

Enable the `rsyncd` service with its original default configuration (will
install and enable xinetd automatically) :

```puppet
xinetd::service { 'rsync': }
```

Disable the above service :

```puppet
xinetd::service { 'rsync': enable => false }
```

Create and enable a new service which will return vmstat output (will install
and enable xinetd automatically) :

```puppet
xinetd::serviceconf { 'vmstat':
  service_type => 'UNLISTED',
  port         => '24101',
  user         => 'nobody',
  server       => '/usr/bin/vmstat',
}
```

Remove the above service :

```puppet
xinetd::serviceconf { 'vmstat':
  ensure => 'absent',
}
```

