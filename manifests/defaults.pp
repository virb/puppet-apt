# =Class: apt::defaults
# This class provides the default values for all parameters used by apt classes

class apt::defaults {
  if $::osfamily != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  # general defaults
  $always_apt_update    = false
  $apt_conf_d           = '/etc/apt/apt.conf.d'
  $backports            = false
  $disable_keys         = false
  $keys                 = {}
  $preferences          = '/etc/apt/apt-preferences'
  $preferences_d        = '/etc/apt/preferences.d'
  $proxy_host           = undef
  $proxy_port           = 8080
  $purge_sources_list   = false
  $purge_sources_list_d = false
  $purge_preferences    = false
  $purge_preferences_d  = false
  $release              = downcase($::lsbdistcodename)
  $sources              = {}
  $update_timeout       = 300
  $update_tries         = 1

  case $::lsbdistid {
    'debian': {
      $backports_key = '46925553'
      $backports_repos = ['main', 'contrib', 'non-free']
      case $::lsbdistcodename {
        'squeeze': {
          $backports_location = 'http://backports.debian.org/debian-backports'
        }
        'wheezy': {
          $backports_location = 'http://ftp.debian.org/debian/'
        }
        default: {
          $backports_location = 'http://http.debian.net/debian/'
        }
      }
    }
    'ubuntu': {
      $backports_key = '437D05B5'
      $backports_repos = ['main', 'universe', 'multiverse', 'restricted']
      case $::lsbdistcodename {
        'precise','trusty': {
          $backports_location = 'http://us.archive.ubuntu.com/ubuntu'
          $ppa_options = '-y'
        }
        'lucid': {
          $backports_location = 'http://us.archive.ubuntu.com/ubuntu'
          $ppa_options = undef
        }
        default: {
          $backports_location = 'http://old-releases.ubuntu.com/ubuntu'
          $ppa_options = '-y'
        }
      }
    }
    default: {
      fail("Unsupported lsbdistid (${::lsbdistid})")
    }
  }
}
