# == Class: firefox::prequisites
#
# This class setups prequisites for Firefox
#
class firefox::prequisites inherits firefox::params {

    if $::kernel == 'windows' {
        include ::chocolatey
    }
}
