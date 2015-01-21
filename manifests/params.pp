#
# == Class: firefox::params
#
# Defines some variables based on the operating system
#
class firefox::params {

    case $::osfamily {
        'RedHat': {
            $package_name = 'firefox'
            $package_provider = undef
            $global_config = '/etc/firefox/pref/syspref.js'
            $file_perms = 644
            $dir_perms = 755
            $source_permissions = undef
        }
        'Debian': {
            $package_provider = undef
            $global_config = '/etc/firefox/pref/syspref.js'
            $file_perms = 644
            $dir_perms = 755
            $source_permissions = undef
 
            case $::operatingsystem {
                'Debian': {
                    $package_name = 'iceweasel'
                    $package_name_locale = 'iceweasel-l10n'
                }
                'Ubuntu': {
                    $package_name = 'firefox'
                    $package_name_locale = 'firefox-locale'
                }
                default: {
                    fail("Unsupported OS: ${::operatingsystem}")
                }
            }
        }
        'FreeBSD': {
            $package_provider = undef
            $package_name = 'firefox'
            $global_config = '/etc/firefox/pref/syspref.js'
            $file_perms = 644
            $dir_perms = 755
            $source_permissions = undef
        }
        'Windows': {
            $package_provider = 'chocolatey'
            $package_name = 'firefox'
            $global_config = "C:\\Program Files (x86)\\Mozilla Firefox\\defaults\\pref\\syspref.js"
            $file_perms = undef
            $dir_perms = undef
            $source_permissions = ignore
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
