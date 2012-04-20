#!/bin/sh

renderFilm()
{
read -p "Please enter a framerate (Default: 12): " FRAMERATE
if [ "$FRAMERATE" = "" ] ; then
	FRAMERATE=12
fi	
read -p "Please enter a filename (Default: timelapse): " FILENAME
if [ "$FILENAME" = "" ] ; then
	FILENAME=timelapese
fi	
ffmpeg -r $FRAMERATE -i %d.jpg -b 15000k $FILENAME.mov
}

control_c()
# run if user hits control-c
{
	echo "\n\nScreen recording stopped."
	echo "Saved $TOTALSHOTS screenshots."
	FILM12FPS=$(($TOTALSHOTS / 12))
	FILM24FPS=$(($TOTALSHOTS / 24))
 	echo "That's $FILM12FPS seconds of film at 12fps and $FILM24FPS seconds at 24fps."
	hash ffmpeg 2>/dev/null || { echo >&2 "No ffmpeg installed, exiting."; exit 1; }
	echo "FFMPEG detected. Would you like to render the screenshots as a movie?"
	select yn in "Yes" "No"; do
    		case $yn in
        		Yes ) (renderFilm); break;;
        		No ) exit;;
    		esac
	done
 	exit $?
}
 
# trap keyboard interrupt (control-c)
trap control_c SIGINT

echo "\nThis will take silent screenshots of your main screen and save them as incrementally numbered jpgs in the current directory until you stop the process with ctrl-c.\n"
read -p "Please enter the shooting interval in seconds (Default: 4): " INTERVAL
if [ "$INTERVAL" = "" ] ; then
	INTERVAL=4
fi
read -p "Enter start value for file numbering (Default: 1)" STARTNUMBER
if [ "$STARTNUMBER" = "" ] ; then
	STARTNUMBER=1
fi
read -p "Optional: enter a width you would like the screenshots resized to:" TARGETWIDTH
echo "\nNow taking screenshots every $INTERVAL seconds, starting at $STARTNUMBER.jpg."
TOTALSHOTS=0
here="`dirname \"$0\"`"
cd "$here"
echo "Screenshots will be saved to $here"
i=$STARTNUMBER;while [ 1 ];
do screencapture -t jpg -x $i.jpg;
if [ "$TARGETWIDTH" != "" ] ; then
	sips $i.jpg --resampleWidth $TARGETWIDTH --out $i.jpg &> /dev/null 
fi
TOTALSHOTS=$i
printf "\rTook $TOTALSHOTS screenshots so far."
let i++;sleep $INTERVAL; done