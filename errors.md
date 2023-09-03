```do

ERROR:

file Stats Table - Peak uni.dta cannot be modified or erased; likely cause is
    read-only directory or file

 If the file you are saving is (or becomes) very large, and the loop otherwise executes quickly, 
 it is possible that the operating system is not done writing out the last version of the file 
 (disk output is very slow compared to computation) when it gets Stata's next request to write 
 out the next version, and at that point the OS may tell Stata the file is inaccessible because it is still busy.

If this is what is happening, the solution is to put a -sleep- command into the loop just after 
the -save- command. That will make Stata wait long enough for the file-write operations to completely 
finish before proceeding to the next iteration of the loop. You will need to do some trial-and-error 
to find out just how much sleep time is needed. I'd start with 500 milliseconds and go up from there 
until the loop consistently runs without failure.
	
sleep 900 // 2 seconds wait before running next command (1000 ms = 1 sec)

```
