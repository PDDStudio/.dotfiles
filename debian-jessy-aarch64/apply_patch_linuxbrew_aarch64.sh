#!/bin/bash

# root directory of linuxbrew
LINUXBREW_MAIN=$HOME/.linuxbrew

# aarch64 support git patch url
GIT_PATCH_URL="https://raw.githubusercontent.com/PDDStudio/.dotfiles/master/debian-jessy-aarch64/"
GIT_PATCH_FILE="support_aarch64.patch"

# validate linuxbrew installation
if [ ! -d "$LINUXBREW_MAIN" ]; then
	echo "Unable to find .linuxbrew directory! Aborting..."
	exit 1
fi

# validate git installation
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "Package <git> not found... Installing it now!"
	sudo apt-get install -y git;
fi

# validate wget installation
if [ $(dpkg-query -W -f='${Status}' wget 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "Package <wget> not found... Installing it now!"
	sudo apt-get install -y wget;
fi

# switch into linuxbrew's root directory
cd $LINUXBREW_MAIN

# fetch, validate and apply the patch
wget $GIT_PATCH_URL/$GIT_PATCH_FILE

if [ ! -f $LINUXBREW_MAIN/$GIT_PATCH_FILE ]; then
	echo "Can't locate $GIT_PATCH_FILE... Aborting!"
	exit 1
fi

git apply --check $GIT_PATCH_FILE

if [ $? -ne 0 ]; then
	echo "Git patch validation failed. Won't apply patch of $GIT_PATCH_FILE!"
	exit 1
fi

git am --signoff < $GIT_PATCH_FILE

if [ $? -ne 0 ]; then
	echo "Something went wrong while applying $GIT_PATCH_FILE..."
	exit 1
fi

echo "$GIT_PATCH_FILE applied successfully!"
exit 0