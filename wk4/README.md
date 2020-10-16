* `!!`: most recently executed command
* `!$`: expand to last command
* `etc`: stores configurations

# Case Statements, Functions

* `type -a case`
* `type -a function`

* `readonly`: makes variable unmodifiable
* `cp -p`: preserves 

# `getopts`

* allow users to change the behavior of the scripts
* eg. user may want output or not.

```bash
while getopts vl:s OPTION
do 
    case ${OPTION} in
    l)
        echo "Something"
        ;;
    ?)
        echo "Another thing"
        exit 1
        ;;
    esac
done
```

## Arithmetic Expansion

```bash
NUM=$(( 1 + 2 ))

NUM=$(( 6 / 4 ))
# Output: 1
# No support for floating point numbers.
# If floating point numbers are needed use `bc`.
```

* `bc -l` for quick calculator
* `awk`
* `let`
* `expr`

```bash
awk 'BEGIN {print 10/4}'
echo '10/4' | bc -l
bc -l

NUM='1'
(( NUM++ ))
echo ${NUM}

NUM=$(( NUM += 5 ))

let NUM='2 + 3'
echo ${NUM}

expr 1 + 1
NUM=$(expr 2 + 3)
echo ${NUM}
```

## Deleting and Disabling Linux Accounts

* `userdel`: delete accounts
* `chage`: change user password expiry information
* `usermod`: modify user account

```bash
sudo chage -E 0 einstein
su -woz
#Expired account

sudo chage -E -1 einstein
su -woz
# Can log in


## Won't work for ssh keys
sudo passwd -l einstein # now locked

sudo passed -u einstein # now unlocked

## Usermod
sudo usermod -s /sbin/nologin einstein
```

**How to find objects that are not in our current path?**

* `locate`: locate from database
* `find`: realtime
* `grep`: displays matches to a pattern and discards everything else.

```bash
locate userdel

locate userdel | grep bin

find /usr/sbin/ -name userdel 

find / -name userdel

find / -name userdel 2>/dev/null
```

## Archive

* `tar`: take archive and overwrites
* `gzip`: zip
* `gunzip`: unzip

OPTION:
* `x`- extract
* `f`- files
* `z`- zipped
* `c`- create
* `v`- verbose