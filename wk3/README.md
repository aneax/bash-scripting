# Advanced Input, Output and Error

* Standard Input : FD 0
* Standard Output : FD 1
* Standard Error : FD 2

`>` : redirect standard output to file
`<` : redirect standard input from file

`>>` : append

* Read
    `read X < /etc/debian_version` is same as `read X 0< /etc/debian_version`

* Write
    `echo "${UID}" > uid` == `echo "${UID} 1> uid"

* Error: to redirect error to a file.
    `head -n1 /etc/passwd /etc/hosts /fakefile 2> head.err`

* Write + Error: 
  * to write output to one file and error to another file
    `head -n1 /etc/passwd /etc/hosts /fakefile > head.out 2> head.err`
  * write output and error to same file
    `head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1` - old way
    
    `head -n1 /etc/passwd /etc/hosts /fakefile &> head.both`

* Append instead of write
  `head -n1 /etc/passwd /etc/hosts /fakefile &>> head.both`

* Piping
   `head -n1 /etc/passwd /etc/hosts /fakefile | cat -n`

   `head -n1 /etc/passwd /etc/hosts /fakefile 2>&1 | cat -n`

   `head -n1 /etc/passwd /etc/hosts /fakefile |& cat -n`


* `&>` : Filename
* `>&` : File descriptor

* Throw away output generate
   `head -n1 /etc/passwd /etc/hosts /fakefile > /dev/null`

   `head -n1 /etc/passwd /etc/hosts /fakefile 2> /dev/null`

   `head -n1 /etc/passwd /etc/hosts /fakefile &> /dev/null`


