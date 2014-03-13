# =Class: apt::update
# This class manages the updating of apt repos
#
# ==Parameters:
# $update_timeout:: exec timeout for update command [Int]
# $update_tries:: number of attempts to try the update command [Int]

class apt::update (
  $update_timeout,
  $update_tries
) {
  exec { 'apt_update':
    command     => "/usr/bin/apt-get update",
    logoutput   => 'on_failure',
    refreshonly => true,
    timeout     => $update_timeout,
    tries       => $update_tries,
    try_sleep   => 1
  }
}
