README
Alexander Tong's Alarm Project
October 2014

I believe all parts of this project have been implemented correctly.
I did not discuss this assignment with anyone.
I spent approximately 8 hours completing this assignment.

The heuristics used in this assignment are not that good as I only use very
simple checks to determine errors. While the 400 level HTTP errors are
probably accurate, the detection of NMAP scans, especially for the server
logs requires a cleartext statement of the usage of the Nmap protocol. Which
would presumably not show up in any sort of "stealthy" scan.

I think it would be more helpful to instead of printing an error for each
detection the program printed information about the whole log after scanning
through it, a summary of the errors detected.

Additionally the shell code detection is very limited, searching only for a 
payload beginning with \x. 
