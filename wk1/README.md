
- [Naming, Command Substitution, Variables](#naming-command-substitution-variables)
  - [Permissions](#permissions)
  - [Add permission `chmod`](#add-permission-chmod)
  - [Directory](#directory)
    - [Rename](#rename)
    - [Create](#create)
  - [Builtin](#builtin)
- [Special Variables and Control Statements](#special-variables-and-control-statements)
  - [Create User](#create-user)

# Naming, Command Substitution, Variables

`#` = sharp
`!` = Bang
`#!` = Shebang

## Permissions

`-rwxrw-r---`

* `r` : read
* `w` : write
* `x` : execute

* `rwx` : permission for user
* `rw-` : permission for group
* `r--` : permisison for everyone else

## Add permission `chmod`

`chmod u=rwx, g=rx, o=r luser-demo1.sh`

Adds execution permission to user and group.

`chmod 754 luser-demo1.sh`

* 4 stands for "read",
* 2 stands for "write",
* 1 stands for "execute", and
* 0 stands for "no permission."

So 7 is the combination of permissions 4+2+1 (read, write, and execute), 5 is 4+0+1 (read, no write, and execute), and 4 is 4+0+0 (read, no write, and no execute).

## Directory

`.` : Current directory
`..`: Parent directory
`pwd`: Current address

### Rename

> `mv`

`mv luser-demo01.sh demo01.sh`

### Create

* Create empty file named blah.sh
> `touch`

`touch blah.sh`

## Builtin

`type -a`

`type echo`
`type -a echo`
`help echo` if shell built in

> `utime`


> `man`

`utime`: how long the system has been running.
`man uptime`: if not built in wth shell.

> `cat`

`cat luser-demo01.sh`

# Special Variables and Control Statements

`UID` : user id

> `id`

* More `bash` defined variables at `man bash` and search for `shell`

`id -u -n` and `id -nu` is identical.

> `whoami`

`type -a [[`

> `type -a test`

**Exit Status**
* 0 - success

> `man useradd` also for exit status

> `${?}` last executed command


> `read`

## Create User

```bash
sudo useradd testusername
sudo su - testusername #use terminal as testusername
ps -ef ##show current running processes
exit
```

`useradd` : add users

`passwd` - password

`userdel` - delete users
