# =Class: apt::preferences
# This class configures apt preferences
#
# ==Parameters:
# $preferences:: path to main preference file [String]
# $preferences_d:: directory of preference files [String]
# $purge_preferences:: purge all unmanaged preferences from the main preference file [Bool]
# $purge_preferences_d:: purge all unmanage preferences from the preference dir [Bool]

class apt::preferences (
  $preferences,
  $preferences_d,
  $purge_preferences,
  $purge_preferences_d
) {
  if $purge_preferences {
    $preferences_content = "Explanation: Preferences managed by Puppet\n
Explanation: We need a bogus package line because of Debian Bug #732746\n
Package: bogus-package\n"
  } else {
    $preferences_content = undef
  }
  debug($preferences_content)

  file { "${preferences}":
    ensure  => present,
    owner  => 'root',
    group   => 'root',
    mode    => '0644',
    content => $preferences_content
  }
    
  file { "${preferences_d}":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    purge   => $purge_preferences_d,
    recurse => $purge_preferences_d,
  }
}
