# == Class: firefox::install
#
# This class installs Mozilla Firefox
#
class firefox::install inherits firefox::params {

    $package_require = $::kernel ? {
        'windows' => Class['chocolatey'],
        default   => undef,
    }

    package { $::firefox::params::package_name:
        ensure   => installed,
        provider => $::firefox::params::package_provider,
        require  => $package_require,
    }
}
