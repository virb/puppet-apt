# =Class: apt::keys
# This class adds apt keys

class apt::keys (
  $keys
) {
  define add_key (
    $ensure,
    $key,
    $key_content,
    $key_server,
    $key_source
  ) {

    anchor { "${module_name}::key::${name}::begin": }
    ->
    apt_key { "${name}":
      ensure  => $ensure,
      id      => $key,
      content => $key_content,
      server  => $key_server,
      source  => $key_source,
      notify  => Exec['apt_update']
    }
    ->
    anchor { "${module_name}::key::${name}::end": }
  }

  $defaults = {
    ensure      => 'present',
    key         => undef,
    key_content => undef,
    key_server  => undef,
    key_source  => undef
  }
  create_resources(add_key, $keys, $defaults)
}
