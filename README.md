# Firefox

A Puppet module for installing Firefox. There is limited support for
configuring per-user settings.

Most desktop operating systems are supported (or rather "should work"). This
includes Fedora, Ubuntu, Debian, FreeBSD and Windows.

# Module usage

To install Firefox and do nothing else:

    class { '::firefox':
      manage_config => false,
    }

To ensure that a certain locale is installed (only required on Ubuntu/Debian):

    ::firefox::locale { 'finnish':
      id => 'fi',
    }

To set Firefox home page for system user 'john':

    ::firefox::profile { 'john':
      homepage => 'http://duckduckgo.com',
    }

For details see [init.pp](manifests/init.pp), [locale.pp](manifests/locale.pp)
 and [profile.pp](manifests/profile.pp).
