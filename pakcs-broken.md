`pakcs` started giving me this error, no matter where I ran it from:

    jeff@jeff-inspiron-2017:~/logic/curry/rslt$ pakcs
    [FATAL ERROR: at Sun Dec  2 17:07:26 2018
            Could not open resource database "/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cypm": Inappropriate ioctl for device]
    
    jeff@jeff-inspiron-2017:~/logic/curry/rslt$ cd ..

After installing `pakcs` (from `pakcs-2.0.2-amd64-Linux.tar.gz`), I had made a copy of the folder. I figured the original must have got corrupted, so I deleted it and replaced it with the copy that I made after first installing. I still got the same "inappropriate ioctl" error. So I tried running `make` again, without first running `make clean`. I got [this error](https://github.com/JeffreyBenjaminBrown/curry-studies/blob/a59cf8ee1a6d469d4dc06aaf34bbe07f884a9d65/pakcs-broken/first-make.txt)[1].

Then I [ran `make clean`, and got no apparent errors](https://github.com/JeffreyBenjaminBrown/curry-studies/blob/a59cf8ee1a6d469d4dc06aaf34bbe07f884a9d65/pakcs-broken/make-clean.txt)[2].

But I still [can't `make` the project](https://github.com/JeffreyBenjaminBrown/curry-studies/blob/a59cf8ee1a6d469d4dc06aaf34bbe07f884a9d65/pakcs-broken/last-make.txt)[3].


# duplicates of embedded links

[1] https://github.com/JeffreyBenjaminBrown/curry-studies/blob/a59cf8ee1a6d469d4dc06aaf34bbe07f884a9d65/pakcs-broken/first-make.txt

[2] https://github.com/JeffreyBenjaminBrown/curry-studies/blob/a59cf8ee1a6d469d4dc06aaf34bbe07f884a9d65/pakcs-broken/make-clean.txt

[3] https://github.com/JeffreyBenjaminBrown/curry-studies/blob/a59cf8ee1a6d469d4dc06aaf34bbe07f884a9d65/pakcs-broken/last-make.txt