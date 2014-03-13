apt
===

## Description

This apt module is an opinionated refactoring of [puppetlabs-apt](https://github.com/virb/puppetlabs-apt) which
respects the graph and runs in a predetermined order. Everytime.

## Overview
This module provides an interface for managing apt sources and keys with Puppet. It always runs in the same order:
`configs -> preferences -> keys -> sources -> updates`.

## Usage
While any clases contained within this module can be called, it is primarily meant to be used from the main class.

Here's a simple example setting up the official Puppet key & repository:

```
class { 'apt':
  keys => {
    'puppet' => {
      key        => '4BD6EC30',
      key_server => 'pgp.mit.edu'
    }
  },
  sources => {
    'puppet' => {
      location   => 'http://apt.puppetlabs.com',
      repos      => 'main'
    }
  }
}
```

As you can see, there is a big difference between this module and the original puppetlabs-apt module. As mentioned above,
the module is expected to be used from the main classs. Instead of declaring numerous `apt::sources` & `apt::keys` resources,
we instead pass hashes to they `keys` and `sources` parameters.
