#
# == Class: firefox::params
#
# Defines some variables based on the operating system
#
class firefox::params {

    include ::os::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'firefox'
            $package_provider = undef
            $global_config = '/etc/firefox/pref/syspref.js'
            $file_perms = '0644'
            $dir_perms = '0755'
        }
        'Debian': {
            $package_provider = undef
            $file_perms = '0644'
            $dir_perms = '0755'

            case $::operatingsystem {
                'Debian': {
                    $package_name = 'iceweasel'
                    $package_name_locale = 'iceweasel-l10n'
                    $global_config = '/etc/firefox/pref/syspref.js'
                }
                'Ubuntu': {
                    $package_name = 'firefox'
                    $package_name_locale = 'firefox-locale'
                    $global_config = '/etc/xul-ext/ubufox.js'
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
            $file_perms = '0644'
            $dir_perms = '0755'
        }
        'Windows': {
            $package_provider = 'chocolatey'
            $package_name = 'firefox'
            $install_dir = 'C:\\Program Files (x86)\\Mozilla Firefox'
            $global_config = "${install_dir}\\browser\\defaults\\preferences\\syspref.js"
            $file_perms = undef
            $dir_perms = undef
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
