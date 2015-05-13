#
# = Class: firefox::config
#
# Configure Mozilla Firefox on a system-wide basis
#
# Note that the system-wide preferences files can't manage some aspects of
# Firefox configuration. A notable example is defining the homepage/startup
# page: on first launch Firefox will read the global value, but never adds it to
# user's prefs.js. This means that on the next launch the user's homepage is set
# to Firefox defaults in prefs.js, which overrides the global configuration.
#
# The information about Firefox preferences on the Internet is mostly obsolete.
# One of the better sources is this:
#
# <http://mike.kaply.com/2012/03/15/customizing-firefox-default-preference-files/>
#
class firefox::config inherits firefox::params
{

    if $::operatingsystem == 'windows' {
        include ::firefox::config::windows
    }

    # System-wide configuration file. Fragments are added to this file as 
    # necessary. This is disabled for now because Puppet runs fail if no 
    # fragments are defined.
    #concat { 'firefox-syspref.js':
    #    path => $::firefox::params::global_config,
    #    ensure => present,
    #    owner => $::os::params::adminuser,
    #    group => $::os::params::admingroup,
    #    warn => true,
    #    mode => $::firefox::params::file_perms,
    #    require => Class['firefox::install'],
    #}
}
