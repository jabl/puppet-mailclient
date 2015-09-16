mailclient
==========

This module configures a machine as a mail client. On Ubuntu it makes
sure there is no mail server installed, and configures heirloom-mailx
to forward via a chosen server. On EL6, it configures postfix in a
"null client" mode.

Example configuration using hiera
---------------------------------

When using hiera, the module can be configured with

    mailclient::relayhost: 'smtp.example.com'
    mailclient::mydomain: 'example.com'


License
-------

Apache License, Version 2.0.

Contact
-------

janne.blomqvist@aalto.fi

Support
-------

Please log tickets and issues at our
[Projects site](https://github.com/jabl/puppet-mailclient)
