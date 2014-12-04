README.txt
Alexander Tong & Benjamin DeButts
December 2014
PART ONE:
Can run command line: can run diff a.jpg b.jpg , a.jpg c.jpg to find that b.jpg differs
Then made our own bash script to brute force a wordlist.
Running kali linux’s metasploit/namelist.txt, we found the password was “ disney “
Which extracted a file named “runme”.
By running `file runme` we determined that “runme” is an executable binary file.
By running `strings runme` we determined that “runme” contains the following interesting strings, as well as a few others:
* blinky_the_wonder_chimp
* Perhaps use your first name as an argument. :-)
* Please send me an email with the subject: I believe that I will win!
* %s, you are doing a heckuvajob up to this point!
We then sent Ming an email with the subject “I believe that I will win”.
He replied: “Fourth”.
The script we used is copied below:
#!/bin/bash
#this script runs the steghide on a specified file using a specified wordlist
#to run this script use the command
# `script [wordlist] [steghide file]`
FILE=$1
while read line
do
        steghide -sf $2 -p $line 2> /dev/null
        if [ $? -eq 0 ]
        then
                echo the password is: $line
        fi
done < $FILE


PART TWO:
We ran dd on the downloaded file, (so that we have a copy of it, and are not messing with the original file), and checked the checksum to ensure it matched. Next we ran autopsy, followed the steps to add a new forensics case, and began navigating autopsy’s web portal.
MD5 of the expanded drive is 73DBDF4075C6037E084D950FACCE83DD
1. Two partitions:
   1. Win95 FAT31 (0x0C), file system type: fat16
   2. Linux (0x83), file system type: ext
2. No, there is not a phone carrier involved. We discovered what appears to be a kali system. See #3 for evidence.
3. Contents Of File: /2/etc/os-release

PRETTY_NAME="Kali GNU/Linux 1.0"
NAME="Kali GNU/Linux"
ID=kali
VERSION="1.0"
VERSION_ID="1.0"
ID_LIKE=debian
ANSI_COLOR="1;31"
HOME_URL="http://www.kali.org/"
SUPPORT_URL="http://forums.kali.org/"
BUG_REPORT_URL="http://bugs.kali.org/"
        
        We conclude from this file that we have a kali operating system version 1.0


4. Disk has various kali applications--like ice weasel, wireshark, various password cracking applications and so on… This was determined by simple file navigation via autopsy in /etc. Various folders titled “iceweasel”, “magic”, “wireshark” and so on, were found.
5. To determine the root password and any user account passwords on the disk we used a combination of ‘unshadow’ and john the ripper to crack the passwords associated with those users. We got the passwd and shadow files from autopsy /etc/*
        Using this method, we found the root password to be “princess”
6. We also found three other user accounts by going to the /home directory via autopsy.
Passwords were cracked as explained in #5.
   a. user: stefani pass: iloveyou
   b. user: judas pass: 00000000
   c. user: alejandro
7. Running foremost with various formats on disk.dd we uncovered numerous jpg, png files of Lady Gaga creepily. There were also pdf files describing security sqlmap usage/FAQs. We also uncovered sched.txt which described a location and date presumably of where lady gaga would be. Also, there was a “note.txt” created, editted, and removed that we gleaned from “stefani”’s bash_history (/home/stefani/.bash_history). “stefani” also had a video of Lady Gaga’s famous vintage nyu performance.
8. Deleted files were found by exploring the directory system using autopsy. We uncovered the following deleted files:
    a. a15.jpg, a16.jpg, a17.jpg found in /home/alejandro presumably images of Lady gaga.
    b. Additionally, in the /home/stefani account we found in the .bash_history that a “note.txt” had been removed.
9. Ran “foremost -s 100 -t jpg -i disk.dd” on the disk and found a bunch of image files including several of a young Lady Gaga. We found a total of 15 jpgs (+ 3 deleted) and 2 pngs of Lady Gaga.
10. In /root/ found a file in the lockbox.txt. Attempting to unzip it led to a password request to unlock “edge.mp4”. Tried the password: “gaga” unlocked a wonderful .mp4 file.
11. Within /home/stefani, a sched.txt was discovered with the following contents:
   a. 12/31/2014: The Chelsea at the Cosmopolitan of Las Vegas Las Vegas, NV 9:00 p.m. PST
   b. 2/8/2015: Wiltern Theatre, Los Angeles, CA, 9:30 p.m. PST
   c. 5/30/2015: Hollywood Bowl, Hollywood, CA, 7:30 p.m. PDT
This suggests that the suspect was planning to see Lady Gaga at one of these places/times.
12. Lady Gaga
