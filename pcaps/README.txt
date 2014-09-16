set1.pcap

1. How many packets are there in this set?
    
    1503

2. What protocol was used to transfer files from PC to server?

    ftp

3. Briefly describe why the protocol used to transfer the files is insecure?

    because username and password are transmitted in cleartext

4. What is the secure alternative to the protocol used to transfer files?

    ftps or sftp, which uses a slightly different technology

5. What is the IP address of the server?

    67.23.79.113

6. What was the username and password used to access the server?

    USER: ihackpineapples
    PASS: rockyou1

7. How many files were transferred from PC to server?

    4

8. What are the names of the files transferred from PC to server?

   BjN-O1hCAAAZbiq.jpg 
   BvgT9p2IQAEEoHu.jpg
   BvzjaN-IQAA3XG7.jpg
   smash.txt

9. Extract all the files that were transferred from PC to server. These files
must be part of your submission!


set2.pcap

10. How many packets are there in this set?

    77882

11. How many plaintext username-password pairs are there in this packet set?

    2

12. Briefly describe how you found the username-password pairs.

    used ethercap and sorted through with grep for "pass:" case insensitive

13. For each of the plaintext username-password pair that you found, identify
the protocol used, server IP, the corresponding domain name (e.g.,
google.com), and port number.

    USER chris@digitalinterlude.com
    PASS Volrathw69
        used POP
        server IP 10.104.15.184
        
        port 110
    
    USER 1
    PASS
        used http
        server IP 10.2.0.168
        defcon-wireless-village
        port 80

IMPORTANT NOTE: PLEASE DO NOT LOG ON TO THE WEBSITE OR SERVICE ASSOCIATED WITH
THE USERNAME-PASSWORD THAT YOU FOUND!

14. Of all the plaintext username-password pairs that you found, how many of
them are legitimate? That is, the username-password was valid, access
successfully granted?

    1 USER chris@digitalinterlude.com

15. How did you verify the successful username-password pairs?

    searched for the packet with the associated ip address 
    and/or searched the associated url

16. What advice would you give to the owners of the username-password pairs
that you found so their account information would not be revealed
"in-the-clear" in the future?

don't use http use https
don't use pop  use imap
