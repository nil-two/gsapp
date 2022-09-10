gsapp
=====

Manege local applications in GNOME Shell

Usage
-----

```
$ gsapp <operation> [...]
manege local applications in GNOME Shell.

operations:
  gsapp add <name> <command> [arg(s)]   # add a new application
  gsapp edit <name>                     # edit a application
  gsapp delete <name(s)>                # delete applications
  gsapp list                            # list applications
  gsapp help                            # show this help message
  gsapp version                         # print the version
```

Installation
------------

gsapp is a simple shell script.

The following instructions assume that `~/bin` is on your `$PATH`.
If that is not the case, you can substitute your favorite location.

```sh
curl -L https://raw.githubusercontent.com/nil-two/gsapp/master/gsapp > ~/bin/gsapp
chmod 755 ~/bin/gsapp
```

License
-------

MIT License

Author
------

nil2 <nil2@nil2.org>
