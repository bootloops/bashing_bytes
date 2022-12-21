#!/bin/bash

############################################################################################################
######### Author: bootloops - part of admintools 
#########
######### Description:
######### Small script used to scrape stuff i wanted from my android phone 
######### using adb, adb push finder.sh, then open a shell and run it
#########
###################################################################################################
#find all images files in home DIR
#
#######
imglist=()
img_jpg=()
img_png=()

######
video_list=()

######
data_sheetlist=()
textlist=()

######
musiclist=()

#######
passwdlist=()
books_list=()
loglist=()

location=$(ls -laR $1)
echo "Usage: ./finder.sh <dir>"
if [[ -z $1 ]]; then
read -p "Enter DIR: " a
location+=$(ls -laR "$a")
fi

for each in ${location[@]}; do
	#Check file extensions
	ext="${each##*\.}" #set to search through ALL

	###CASE SET ONLY TO SHOW .sh FILES
	case "$ext" in
	jpg | JPG | png | PNG | gif | GIF | jpeg | JPEG | TIFF | tiff | BMP | bmp | svg | SVG ) imglist+=("$each"); echo -ne "[ IMAGE FILE [ ${#imglist[*]} ] ] $each\\r";;
	mp3 | MP3 | aac | AAC | flac | FLAC | OGG | ogg | WMA | wma | wav | WAV ) musiclist+=("$each"); echo -ne "\\t[ MUSIC FILE [ ${#muslist[*]} ] ] $each\\r";;
	doc | DOC | DOCX | docx | MSG | msg | ODT | odt | pages | PAGES | rtf | RTF | tex | TEX | txt | TXT | WPD | wpd | WPS | wps ) textlist+=("$each"); echo -ne "\\t\\t[ TEXT FILE [ ${#textlist[*]} ] ] $each\\r";;
	csv | CSV | dat | DAT | GED | ged | key | KEY | KEYCHAIN | passwd | PASSWD | keychain | pps | PPS | PPT | ppt | PPTX | pptx | SDF | sdf | TAR | tar | TAX2016 | tax2016 | TAX2019 | tax2019 | VCF | vcf | XML | xml) data_sheetlist+=("$each"); echo -ne "\\t\\t\\t[ DATASHEET FILE [ ${#data_sheetlist[*]} ] ] $each\\r";;
	3g2 | 3G2 | 3gp | 3GP | ASF | asf | AVI | avi | FLV | flv | M4V | m4v | MOV | mov | MP4 | mp4 | MPG | mpg | RM | rm | SRT | srt | SWF | swf | VOB | vob | WMV | wmv) video_list+=("$each"); echo -ne "\\t\\t\\t\\t[ VIDEO FILE [ ${#video_list[*]} ] ] $each\\r";;
	EPUB | epub | MOBI | mobi | pdf | PDF | md | MD ) books_list+=("$each"); echo -ne "[ READER/BOOK FILE [ ${#books_list[*]} ] ] $each\\r";;
	log | log.1 | log.2 | log.3 | LOG ) loglist+=("$each"); echo -ne " [ LOGS [ ${#loglist[*]} ] ]\\r";;
	*) ;;
	esac

done

#REPORT ON FINDINGS
printf "\n\t [ ${#imglist[*]} ] IMAGES \t [ ${#muslist[*]} ] MUSIC \n"
printf "\n\t [ ${#video_list[*]} ] VIDEOS \t [ ${#data_sheetlist[*]} ] DATASHEETS \n"
printf "\n\t [ ${#txtlist[*]} ] TEXT/WORD DOCS \n"