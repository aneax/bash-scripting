# Transforming Data/Data Processing

## Cut and Awk

* `cut`: remove sections from each line of files
  * `-c`: by character
  * `-b`: by byte 
  * `-f`: by field, tab

```bash
# Shows character of first line of /etc/passwd
cut -c 1 /etc/passwd
# Now 7th line
cut -c 7 /etc/passwd

# With starting and end positions
cut -c 1-7 /etc/passwd

# From 7 to end
cut -c 7- /etc/passwd

# From beginning to 7
cut -c -7 /etc/passwd 

# 1,5 and 7th character
cut -c 1,5,7 /etc/passwd

# Rearranging doesn't change output
cut -c 5,7,1 /etc/passwd

# Empty line if line doesn't contain character
cut -c -100 /etc/passwd

# Tabs
echo 'one\ttwo\tthree' | cut -f 1

# Delimiter
echo 'one,two,three' | cut -d ',' -f 1

# Example
cut -d ':' -f 1,3 /etc/passwd

# Change delimiter
cut -d ':' -f 1,3  --output-delimiter=',' /etc/passwd

# CSV
echo 'name,goals' > football.csv
echo 'cr,504' >> football.csv
echo 'mess,497' >> football.csv
echo 'ney,343' >> football.csv
echo 'bappe,129' >> football.csv
```

**Regular Expressions**
* `^`: Beginning of line
* `$`: End of line

```bash
grep '^name' football.csv
grep 'e$' football.csv

# Header file
grep '^name,goals$' football.csv

# Everything except header
grep -v '^name,goals$' football.csv

# Now cut,
grep -v '^name,goals$' football.csv | cut -d ',' -f 1
```

> * Cut only take one character as delimiter

```bash
echo 'DATA:nameDATA:goals' > foo.dat
echo 'DATA:crDATA:504' >> foo.dat
echo 'DATA:messDATA:497' >> foo.dat
echo 'DATA:neyDATA:343' >> foo.dat
echo 'DATA:bappeDATA:129' >> foo.dat
# This doesn't work
cut -d 'DATA:' -f 2 foo.dat
```

* `awk`

```bash
awk -F ':' '{print $1, $3}' /etc/passwd

# With separator
awk -F ':' -v  OFS=',' '{print $1, $3}' /etc/passwd #Change field separator to ','

# With additional label
awk -F ':' -v  OFS=',' '{print "COL1: "$1, " COL3: "$3}' /etc/passwd

# Change Order
awk -F ':' -v  OFS=',' '{print  "COL3: "$3 " COL1: "$1}' /etc/passwd

#  $NF = number of fields found
awk -F ':' '{print $NF}' /etc/passwd #Last field

# Second last field 
awk -F ':' '{print $(NF - 1)}' /etc/passwd

# Previous example
awk -F 'DATA:' '{print $2}' foo.dat 

# Dealing with random spaces
echo 'L1C1      L1C2' > lines.dat
echo '    L2C1 L2C2' >> lines.dat
echo '  L3C1    L3C2' >> lines.dat
echo -e 'L4C1\tL4C2' >> lines.dat

awk '{print $1, $2}'  lines.dat
```

* `netstat`: print network connections

```bash
# Remove row without ':'
netstat -nutl |  netstat -nutl | grep ':'

# Remove row starting with Active and Proto
netstat -nutl | grep -v '^Active' | grep -v '^Proto'
# Equivalent to 
netstat -nutl | grep -Ev '^Active|^Proto'

# 
netstat -nutl | grep -Ev '^Active|^Proto' | awk '{print $4}' | awk -F ':' '{print $NF}'
```

## Sort and Uniq

* `sort`

```bash
# Sort alphabetically
sort /etc/passwd

# Sort reverse
sort -r /etc/passwd

# Sort uid
cut -d ':' -f 3 /etc/passwd | sort  -n

# Numeric sort with 3rd key separated by ':' 
cat /etc/passwd | sort -t ':' -k 3 -n
```

* `du`: file space usage/ disk usage in KiloBytes

```bash
# Print disk usage in ascending order
sudo du /var | sort -n

# Print in human readable way (sort doesn;t work for this in regular way)
sudo du -h /var

# For human numeric sort
sudo du -h /var | sort -h

# Has duplicates
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n

# For unique -u
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu
```

* `uniq` need sorted input to work

```bash
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq

# To get number of occurances -c
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c
```

* `wc` : Count
  * `-w`: words
  * `-c`: bytes
  * `-l`: kines

```bash
# Print number of lines,  words and size
wc /etc/passwd

# Which accounts are using bash shell and count it
grep bash /etc/passwd | wc -l
#or
grep -c bash /etc/passwd
```