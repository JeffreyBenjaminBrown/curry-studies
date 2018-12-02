`pakcs` started giving me this error, no matter where I ran it from:

    jeff@jeff-inspiron-2017:~/logic/curry/rslt$ pakcs
    [FATAL ERROR: at Sun Dec  2 17:07:26 2018
            Could not open resource database "/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cypm": Inappropriate ioctl for device]
    
    jeff@jeff-inspiron-2017:~/logic/curry/rslt$ cd ..

After installing `pakcs` (from `pakcs-2.0.2-amd64-Linux.tar.gz`), I had made a copy of the folder. I figured the original must have got corrupted, so I deleted it and replaced it with the copy that I made after first installing. I still got the same "inappropriate ioctl" error. So I tried running `make` again, without first running `make clean`. I got this error[1].

Then I ran `make clean`, and got no apparent errors[2].

But I still can't `make` the project[3].
