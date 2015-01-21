#
# = Class: firefox::config
#
# Configure Mozilla Firefox on a system-wide basis
#
class firefox::config
(
    $homepage
)
{

    include os::params
    include firefox::params

    if $operatingsystem == 'windows' {
        include firefox::config::windows
    }

    # System-wide configuration file. Fragments are added to this file as 
    # necessary.
    concat { 'firefox-syspref.js':
        path => $::firefox::params::global_config,
        ensure => present,
        owner => $::os::params::adminuser,
        group => $::os::params::admingroup,
        warn => true,
        mode => $::firefox::params::file_perms,
        require => Class['firefox::install'],
    }

    concat::fragment { 'firefox-default-homepage.js':
        target => 'firefox-syspref.js',
        content => template('firefox/homepage.js.erb'),
        owner => $::os::params::adminuser,
        group => $::os::params::admigroup,
        mode => $::firefox::params::file_perms,
    }
}
