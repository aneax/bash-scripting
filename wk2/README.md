# Password Generation and Shell Script Arguments

* Check `man bash` for random number generators
* `date`
* `%s` seconds time 1970
* `%N` nanoseconds

* `ls -l /usr/bin/*sum` : check files with `*sum`

* `head -n2 /etc/passwd`: 2 lines
* `head -c2 /etc/passwd`: 2 characters

* `date +%s | sha256sum | head -c8`

* > `shuf`: random permutations

* > `fold`: transform single line into multiple line

* `|`- pipe

## Path Variables

* `hash -r`

* `sudo cp /usr/local/bin/ filename`:  to execute without entering full path.

* `basename`: strips the directory portion of the string
* `dirname`: strips last component from filename

* `for`

```bash
for USER_NAME in "${@}"
do
    PASSWORD=$(date +%s%N | sha256sum | head -c48)
    echo "${USER_NAME}: ${PASSWORD}"
done
```

* `while`
* `true`
* `sleep`
* `shift`