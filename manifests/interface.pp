define udev::interface (
                          $priority='70',
                          $filename='puppet-managed-persistent-net',
                          $interfacename=$name,
                          $macaddr,
                        ) {

  # root@index:/etc/udev/rules.d# cat /etc/udev/rules.d/70-persistent-net.rules
  # SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:50:56:01:32:41", ATTR{type}=="1", KERNEL=="eth*", NAME="eth3"
  #
  # SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:50:56:01:32:42", ATTR{type}=="1", KERNEL=="eth*", NAME="eth2"
  #

  if ! defined(Class['udev'])
  {
    fail('udev class is required')
  }

  if ! defined(Concat["${udev::params::confbase}/${priority}-${filename}.rules"])
  {
    concat { "${udev::params::confbase}/${priority}-${filename}.rules":
      ensure => 'present',
      owner => 'root',
      group => 'root',
      mode => '0644',
    }

    concat::fragment{ "${udev::params::confbase}/${priority}-${filename}.rules header":
      target  => "${udev::params::confbase}/${priority}-${filename}.rules",
      content => "#\n# PUPPET MANAGED FILE, DO NOT EDIT\n#\n\n",
      order => '00',
    }
  }

  concat::fragment{ "${udev::params::confbase}/${priority}-${filename}.rules regla ${interfacename} ${macaddr}":
    target  => "${udev::params::confbase}/${priority}-${filename}.rules",
    content => "SUBSYSTEM==\"net\", ACTION==\"add\", DRIVERS==\"?*\", ATTR{address}==\"${macaddr}\", ATTR{type}==\"1\", KERNEL==\"eth*\", NAME=\"${interfacename}\"\n\n",
    order => '01',
  }

}
