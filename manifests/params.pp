class udev::params {

  $confbase='/etc/udev/rules.d'

  case $::osfamily
  {
    'redhat' :
    {
    }
    'Debian':
    {
    }
    'Suse':
    {
    }
    default  : { fail('Unsupported OS!') }
  }
}
