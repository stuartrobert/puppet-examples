# base profile
class profile::base {

  case $facts['os']['family'] {
    'RedHat': {
      include profile::base::unix
      include elbase
    }
    'Debian': {
      if $facts['os']['lsb']['distid'] == 'Raspbian' {
        include profile::base::raspbian
      }
      include profile::base::unix
      include debbase
    }
    'Darwin': { # Mac OSX
      include profile::base::unix
      #include osxbase
    }
    'windows': {
      include winbase
      include profile::win_users
    }
    default: {
      fail "unsupported OS family ${facts['osfamily']}"
    }
  }

  include profile::puppet_agent

}
