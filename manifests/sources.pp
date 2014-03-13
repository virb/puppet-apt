# =Class: apt::sources
# This class configures apt repo sources

class apt::sources (
  $backports,
  $backports_key,
  $backports_repos,
  $backports_location,
  $release,
  $sources
) {
  define create_source (
    $architecture,
    $ensure,
    $include_src,
    $location,
    $pin,
    $release,
    $repos,
  ) {

    anchor { "${module_name}::source::${name}::begin": }
    ->
    file { "${name}.list":
      ensure => $ensure,
      path   => "/etc/apt/sources.list.d/${name}.list",
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      content => template("${module_name}/source.list.erb"),
      notify  => Exec['apt_update']
    }
    ->
    anchor { "${module_name}::source::${name}::end": }
  }

  $defaults = {
    architecture => undef,
    ensure       => 'present',
    include_src  => false,
    pin          => undef,
    release      => $release
  }
  create_resources(create_source, $sources, $defaults)
}
