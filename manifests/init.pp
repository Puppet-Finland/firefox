# == Class: firefox
#
# This class install and configures Mozilla firefox.
#
# This module has been tested on Linux (Ubuntu 14.04) and Windows 7 64-bit. 
# Other *NIX variants such as RedHat, Debian and FreeBSD as well as 32-bit 
# Windows have not been tested, but should work out of the box or with minor 
# modifications. Adding MacOS X support should be fairly straightforward.
#
# == Parameters
#
# [*manage*]
#   Manage Mozilla firefox using this module. Valid values 'yes' (default) 
#   and 'no'. This is primarily needed with Hiera where excluding classes 
#   inherited from the lower levels in the hierarchy is not possible.
# [*manage_config*]
#   Manage Mozilla firefox configuration. Valid values 'yes' (default) and 
#   'no'.
# [*locales*]
#   A hash of firefox::locale resources to realize. Currently only needed on 
#   Debian and Ubuntu where the locales are packaged separately. Defining these 
#   on other operating systems is harmless.
#   email accounts, but their use can be extended to other areas.
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
    $manage = 'yes',
    $manage_config = 'yes',
    $locales = {}

) inherits firefox::params
{

if $manage == 'yes' {

    include firefox::install
    create_resources('firefox::locale', $locales)

    if $manage_config == 'yes' {
        # TODO
    }
}
}
