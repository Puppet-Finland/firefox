#
# == Define: firefox::profile
#
# Create a Mozilla Firefox profile for a user. The profile name is hardcoded 
# to keep things manageable.
#
# == Parameters
#
# [*username*]
#   User's system username. Affects the location of the profile files. Defaults 
#   to resources $title.
# [*homepage*]
#   The user's homepage. Defaults to 'about:home'.
#
define firefox::profile
(
    $username = $title,
    $homepage = 'about:home'
)
{
    include ::os::params
    include ::firefox::params

    # The profile name is hardcoded for now for simplicity.
    $profilename = "puppet-${::fqdn}.default"

    if $::osfamily == 'windows' {
        $mozilla_dir = "${::os::params::home_bs}\\${username}\\AppData\\Roaming\\Mozilla"
        $firefox_dir = "${mozilla_dir}\\firefox"
        $profiles_dir = "${firefox_dir}\\Profiles"
        $profile_dir = "${profiles_dir}\\${profilename}"
        $profiles_ini = "${firefox_dir}\\profiles.ini"
        $profile_path = "Profiles/${profilename}"
        $user_js = "${profile_dir}\\user.js"

        # Create the directory structure. Note how Windows stores profiles in a 
        # dedicated directory.
        file { [ $mozilla_dir,
                $firefox_dir,
                $profiles_dir,
                $profile_dir ]:
            ensure => directory,
            owner  => $username,
        }

    } else {
        $mozilla_dir = "${::os::params::home}/${username}/.mozilla"
        $firefox_dir = "${mozilla_dir}/firefox"
        $profiles_dir = $firefox_dir
        $profile_dir = "${profiles_dir}/${profilename}"
        $profiles_ini = "${firefox_dir}/profiles.ini"
        $profile_path = $profilename
        $user_js = "${profile_dir}/user.js"

        # Create the directory structure. Profiles are stored directly in the 
        # "firefox" directory, unlike on Windows.
        file { [ $mozilla_dir,
                $firefox_dir,
                $profile_dir ]:
            ensure => directory,
            owner  => $username,
            mode   => $::firefox::params::dir_perms,
        }
    }

    # Create user's profile.ini
    #
    # We can't depend on $profiles_dir because we don't realize that on *NIX.
    file { "firefox-profiles.ini-${username}":
        name    => $profiles_ini,
        content => template('firefox/profiles.ini.erb'),
        owner   => $username,
        mode    => $::firefox::params::file_perms,
        require => File[$profile_dir],
    }

    # Create the user.js file that overrides any settings in prefs.js on startup
    concat { "firefox-user.js-${username}":
        ensure  => present,
        path    => $user_js,
        owner   => $username,
        warn    => true,
        mode    => $::firefox::params::file_perms,
        require => File[$profile_dir],
    }

    concat::fragment { "firefox-user.js-${username}-homepage":
        target  => "firefox-user.js-${username}",
        content => template('firefox/homepage.js.erb'),
    }
}
