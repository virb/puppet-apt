# =Class: apt
# This module manages configuration of apt repos and preferences.
#
# ==Parameters:
# $always_apt_update:: rather apt should be updated on every run [Bool] [Default: false]
# $backports:: setup backports repo [Bool] [Default: false]
# $backports_key:: gpg key for the backports repo [String] [Default: debian:46925553, ubuntu:437D05B5]
# $backports_location:: main url to the backports repo [String] [Default: Dist-specific]
# $backports_repos:: backport repos to add to apt [Array] [Default: Dist-specific]
# $disable_keys:: disables the requirement for all packages to be signed [Bool] [Default: false]
# $preferences_d:: directory of preference files [String] [Default: /etc/apt/preferences.d]
# $purge_sources_list:: purge all unmanaged entries from sources.list [Bool] [Default: false]
# $purge_sources_list_d:: purge all unmanaged entries from sources.list.d [Bool] [Default: false]
# $update_timeout:: exec timeout in seconds for apt-get update [Int] [Default: 300]
# $update_tries:: number of `apt-get update` tries [Int] [Default: 1]
#
# ==Requires:
# * puppetlabs/stdlib

class apt(
  $always_apt_update    = $always_apt_update,
  $apt_conf_d           = $apt_conf_d,
  $backports            = $backports,
  $backports_key        = $backports_key,
  $backports_location   = $backports_location,
  $backports_repos      = $backports_repos,
  $disable_keys         = $disable_keys,
  $keys                 = $keys,
  $preferences          = $preferences,
  $preferences_d        = $preferences_d,
  $proxy_host           = $proxy_host,
  $proxy_port           = $proxy_port,
  $purge_sources_list   = $purge_sources_list,
  $purge_sources_list_d = $purge_sources_list_d,
  $purge_preferences    = $purge_preferences,
  $purge_preferences_d  = $purge_preferences_d,
  $release              = $release,
  $sources              = $sources,
  $update_timeout       = $update_timeout,
  $update_tries         = $update_tries
) inherits apt::defaults {

  anchor { "${module_name}::begin": }
  ->
  class { "${module_name}::preferences":
    preferences          => $preferences,
    preferences_d        => $preferences_d,
    purge_preferences    => $purge_preferences,
    purge_preferences_d  => $purge_preferences_d
  }
  ->
  class { "${module_name}::keys":
    keys => $keys
  }
  ->
  class { "${module_name}::sources":
    backports          => $backports,
    backports_key      => $backports_key,
    backports_repos    => $backports_repo,
    backports_location => $backports_location,
    release            => $release,
    sources            => $sources
  }
  ->
  class { "${module_name}::update":
    update_timeout => $update_timeout,
    update_tries   => $update_tries
  }
  ->
  anchor { "${module_name}::end": }
}
