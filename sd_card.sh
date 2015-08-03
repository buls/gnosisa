#!/bin/bash
# Checks if root/sudo
myname=`whoami`
if [ $myname = root ]; then
        echo ""
        echo "Running as root/sudo, proceeding to format script."
        echo "Don't forget to verify the device/partition"
else
        echo "You must be root to run this script"
        echo "Also, don't forget to verify the device/partition"
        exit 1
fi

#md5sum function
function file_check()
{
COUNTER=0
while [  $COUNTER -lt 3 ]; do
	copied_file=2015-05-05-raspbian-wheezy.zip # Name of copied file
	md5_file=2015-05-05-raspbian-wheezy.md5 # Name of md5 file
	md5sum $copied_file # Generate md5 hash of zip file
	if md5sum -c $md5_file; then # Compare hash to original hash file
		echo "checksums OK" 
		break # If ok, we are good to go!
	else
		echo "md5 sums mismatch"
		let COUNTER=COUNTER+1 
		# Check if check runs more than twice, terminate script.
		if [ $COUNTER -eq 2 ]
		then
			echo "Please delete the following corrupt files from your home directory and run the script again"
			echo "- 2015-05-05-raspbian-wheezy.zip"
			echo "- 2015-05-05-raspbian-wheezy.md5"
			exit 1
		fi
		echo "Trying $COUNTER more time(s)"
	fi
done
}
#end of md5sum function
if [[ -s 2015-05-05-raspbian-wheezy.zip && -s 2015-05-05-raspbian-wheezy.md5 ]]; then 
	echo "ZIP File already exists"
	echo "Checking file validity.."
	file_check
else
	echo "We need to connect to a server(repository) to fetch the Raspian Image"
	echo "Please enter username of server : "
	read user_name
	echo "Please enter host name or ip address of server : "
	read ip
	scp $user_name@$ip:/home/bluefox/kalite-repo/\{2015-05-05-raspbian-wheezy.zip,2015-05-05-raspbian-wheezy.md5\} .
	file_check
fi
unzip 2015-05-05-raspbian-wheezy.zip

#Start of Installation
df -h # Views all devices including partitions on this very computer
echo "Please check for the name of your sd card beside /dev/ with its corresponding disk size."
echo "E.g. for /dev/sda, 'sda' is the disk name."
echo "Warning! Please confirm the name correctly to avoid BUM!!!"
sleep 1 # Slight pause
echo "Type the SD card name : "
read sd_card_name # Reads user input
echo "You typed" $sd_card_name # Prints user input
umount /dev/$sd_card_name # Unmounts sd card
echo "Unmounting...."
sleep 1.5 # Slight pause
echo "SD Card has been unmounted"
echo "Formatting SD Card"
mkfs.vfat /dev/$sd_card_name

echo "The name of the SD card entered previously was $sd_card_name"
echo "Now, Please re type the name of the SD card omitting partition names : "
echo "e.g. if sd card name is 'sda1' or 'sdap1' or 'sdas1', type 'sda' only"
echo "e.g. if sd card name is 'mmcblk0p1', type 'mmcblk0' only"
echo "Failure to do this will result in a failed installation"
echo "Rapsberry Pi would be unable to boot into Rapsbian OS"
read sd_card_name_only # Reads user input
echo "Initiating Installation of Rapsbian OS."
dd bs=4M if=./2015-05-05-raspbian-wheezy.img of=/dev/$sd_card_name_only
rm 2015-05-05-raspbian-wheezy.img
sync
echo "Installation complete!"
