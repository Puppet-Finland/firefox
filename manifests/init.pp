# == Class: firefox
#
# This class installs and configures Mozilla firefox.
#
# == Parameters
#
# [*manage*]
#   Manage Mozilla Firefox using this module. Valid values true (default) and 
#   false. This is primarily needed with Hiera where excluding classes inherited 
#   from the lower levels in the hierarchy is not possible.
# [*manage_config*]
#   Manage Mozilla firefox configuration. Valid values true (default) and 
#   'false.
# [*locales*]
#   A hash of firefox::locale resources to realize. Currently only needed on 
#   Debian and Ubuntu where the locales are packaged separately. Defining these 
#   on other operating systems is harmless.
# [*profiles*]
#   A hash of firefox::profile resources to realize. There is one of these
#   per-user on a single system.
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class firefox
(
    Boolean $manage = true,
    Boolean $manage_config = true,
            $locales = {},
            $profiles = {}

) inherits firefox::params
{

if $manage {

    include ::firefox::prequisites
    include ::firefox::install
    create_resources('firefox::locale', $locales)

    if $manage_config {
        class { '::firefox::config': }
        create_resources('firefox::profile', $profiles)
    }
}
}
