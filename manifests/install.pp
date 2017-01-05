# == Class: firefox::install
#
# This class installs Mozilla Firefox
#
class firefox::install inherits firefox::params {

    package { $::firefox::params::package_name:
        ensure   => installed,
        provider => $::firefox::params::package_provider,
        require  => $::firefox::params::package_require,
    }
}
