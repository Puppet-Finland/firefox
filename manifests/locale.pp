#
# == Define: firefox::locale
#
# Ensure a firefox locale is present on the system. Only needed on 
# Debian/Ubuntu at the moment.
#
# == Parameters
#
# [*id*]
#   Define the country code for the locale to instal. For example use 'fi' for 
#   Finnish or 'it' for Italian.
#
define firefox::locale
(
    $id
)
{
    include ::firefox::params

    if $::osfamily == 'Debian' {
        package { "firefox-locale-${id}":
            ensure  => installed,
            name    => "${::firefox::params::package_name_locale}-${id}",
            require => Class['firefox::install'],
        }
    }
}
