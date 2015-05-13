#
# == Class: firefox::config::windows
#
# Windows-specific configuration of Firefox.
#
# Currently this class creates the proper directory structure for the 
# system-wide Firefox configuration file.
# 
class firefox::config::windows inherits firefox::params
{

    $browser_dir = "${::firefox::params::install_dir}\\browser"
    $defaults_dir = "${browser_dir}\\defaults"
    $preferences_dir = "${defaults_dir}\\preferences"

    file { [ $browser_dir,
            $defaults_dir,
            $preferences_dir ]:
        ensure  => directory,
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        require => Class['firefox::install'],
        #before => Concat['firefox-syspref.js'],
    }
}
