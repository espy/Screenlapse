Screenlapse
===========

A bash script for os x that makes a timelapse video of your screen with ffmpg.

What it does
------------

* Takes incrementally numbered screenshots of your main monitor at a definable interval, and at a definable resolution. 
* If you have ffmpeg installed, it will let you render these screenshots to a .mov file at an arbitrary framerate.

How to use it
-------------

* Clone screenlapse.command to wherever you want your screenshots and the video.
* Make the file executable (via cmd-i or chmod +x screenlapse.command).
* Double click it. 

If you're in a hurry, just smash the enter key three times to start recording with defaults, otherwise, you can set these parameters:
* __Interval__: number of seconds between each screenshot. Default is 4.
* __Starting value for incremental numbering__: if you exited the script before and want to resume now, put the name of the last screenshot +1 here (if your last screenshot was 2214.jpg, enter 2215 here). Default is 1.
* __Target width__: Whatever you want the width if the resulting images/video to be, i.e "640". Correct aspect ratio is maintained. Defaults to your screen resolution. 

You can then stop the screenshotting with ctrl-c. If ffmpeg is installed, you will then be prompted whether you want to render the screenshots into a -mov file. If yes, you will be prompted for:
* __Framerate__: Target framerate of the .mov. Default is 12.
* __Filename__: The name of the .mov file. Default is "timelapse".

Careful: screenlapse will overwrite any existing files without warning. 

Installing ffmpeg:
-----------------

If you have homebrew installed: ```$ brew install ffmpeg```

Otherwise try: 

    $ svn checkout svn://svn.ffmpeg.org/ffmpeg/trunk ffmpeg
    $ cd ffmpeg
    $ ./configure --enable-shared --disable-mmx
    $ sudo make
    $ sudo make install

(I could never make this work)

Stuff
-----

Screenlapse happened because of [this blog post](http://labs.laan.com/wp/2011/01/how-to-make-time-lapse-screencaptures-of-your-design-work-for-free-mac/), so thanks to those two guys.
