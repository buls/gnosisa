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

#First write from primary card to current folder
df -h # Views all devices including partitions on this very computer
echo "First write"
echo "Please check for the name of your sd card beside /dev/ with its corresponding disk size."
echo "E.g. for /dev/sda, 'sda' is the disk name."
echo "Please type the name of the SD card omitting partition names : "
echo "e.g. if sd card name is 'sda1' or 'sdap1' or 'sdas1', type 'sda' only"
echo "e.g. if sd card name is 'mmcblk0p1', type 'mmcblk0' only"
echo "Failure to do this will result in a corrupt copied image"
echo "Warning! Please confirm the name correctly to avoid BUM!!!"
sleep 1 # Slight pause
read sd_card_name # Reads user input
echo "You typed" $sd_card_name # Prints user input
echo "Initiating write from SD Card to current folder"
dd if=/dev/$sd_card_name of=sd_image.img bs=4M
echo "First write complete!"

#Second write from current folder to new card
echo "Second write"
echo "Now, Remove the original SD card and insert the empty(new) one"
echo "Please make sure it is mounted"
df -h
echo "Please check for the name of your sd card beside /dev/ with its corresponding disk size."
echo "Now, Please type the name of the new SD card omitting partition names : "
echo "e.g. if sd card name is 'sda1' or 'sdap1' or 'sdas1', type 'sda' only"
echo "e.g. if sd card name is 'mmcblk0p1', type 'mmcblk0' only"
echo "Failure to do this will result in a failed installation"
echo "Rapsberry Pi would be unable to boot into Rapsbian OS"
echo "Warning! Please confirm the name correctly to avoid BUM!!!"
sleep 1 # Slight pause
echo "Type the SD card name : "
read new_sd_card_name # Reads user input
echo "You typed" $new_sd_card_name # Prints user input
umount /dev/$new_sd_card_name # Unmounts sd card
echo "Unmounting...."
sleep 1.5 # Slight pause
echo "SD Card has been unmounted"
echo "Initiating write from current folder to SD card"
dd if=sd_image.img of=/dev/$new_sd_card_name bs=4M
sync
echo "Image re-write complete!"
echo "Bye"
