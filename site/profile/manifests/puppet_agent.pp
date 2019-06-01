# manage the puppet-agent module
class profile::puppet_agent(
String $pkg_version,
String $collection_version = '5',
) {

  $collection = "puppet${collection_version}"

  case $facts['os']['family'] {
    'RedHat', 'Darwin', 'windows', 'Debian': {
      if $facts['os']['name'] != 'Raspbian' {
        class { 'puppet_agent':
          package_version => $pkg_version,
          collection      => $collection,
        }
      } else {
        # there aren't packages built for Raspbian :-(
      }
    }
    default: {
      fail "unsupported OS family ${facts['osfamily']}"
    }
  }


}
