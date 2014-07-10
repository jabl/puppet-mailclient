# == Class: mailclient
#
# This class configures a system as a mail client, that is a machine
# where no mail is stored locally, and all mail is forwarded to some
# other server.
#
# === Parameters
#
# [relayhost]
#   SMTP server to relay mail via, see postconf(5) man page for more info.
#
# [mydomain]
#   Domain name for system, see postconf(5) man page.
#
# === Examples
#
#  class { mailclient:
#    relayhost => 'smtp.example.com',
#    mydomain  => 'example.com'
#  }
#
# === Authors
#
# Janne Blomqvist <janne.blomqvist@aalto.fi>
#
# === Copyright
#
# Copyright 2014 Janne Blomqvist
#
class mailclient {

  case $::osfamily {
    'Debian': {
      package { "mailutils": ensure => purged }
      package { "heirloom-mailx": ensure => installed }
      package { "postfix": ensure => purged }
      package { "exim4-base": ensure => purged }

      file { "/etc/nail.rc":
        mode     => 0644,
        owner    => root,
        group    => root,
        require  => Package["heirloom-mailx"],
        content  => template('mailclient/nail.rc.erb')
      }
    }
    
    'RedHat': {
      package { "postfix": ensure => installed }

      file { "/etc/postfix/main.cf":
        mode    => 0644,
        owner   => root,
        group   => root,
        content => template('mailclient/main.cf.erb'),
        require => Package["postfix"],
      }

      service { 'postfix':
        ensure    => running,
        enable    => true,
        subscribe => File["/etc/postfix/main.cf"],
      }

    }
}
