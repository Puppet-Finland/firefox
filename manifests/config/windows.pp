#
# == Class: firefox::config::windows
#
# Windows-specific configuration of Firefox.
#
# Currently this class creates the proper directory structure for the 
# system-wide Firefox configuration file. For some reason the Firefox package 
# itself does _not_ do this, and the Internet is full of obsolete information. 
# The only up-to-date and useful page was this:
#
# <http://mike.kaply.com/2012/03/15/customizing-firefox-default-preference-files/>
#
class firefox::config::windows inherits firefox::params
{

    file { 'firefox-browser-dir':
        name => "${::firefox::params::install_dir}\\browser",
        ensure => directory,
        before => Concat['firefox-syspref.js'],
        require => Class['firefox::install'],
        source_permissions => $source_permissions,
    }

    file { 'firefox-defaults-dir':
        name => "${::firefox::params::install_dir}\\browser\\defaults",
        ensure => directory,
        require => File['firefox-browser-dir'],
        source_permissions => $source_permissions,
    }

    file { 'firefox-preferences-dir':
        name => "${::firefox::params::install_dir}\\browser\\defaults\\preferences",
        ensure => directory,
        require => File['firefox-defaults-dir'],
        source_permissions => $source_permissions,
    }
}
