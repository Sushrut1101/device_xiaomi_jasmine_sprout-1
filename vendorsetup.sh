#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2022 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="jasmine_sprout"
#set -o xtrace

fox_get_target_device(){
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
	if [ -n "$chkdev" ]; then
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export LC_ALL="C"
	export ALLOW_MISSING_DEPENDENCIES=true

	export TW_DEFAULT_LANGUAGE="en"
	export OF_AB_DEVICE=1
	export TARGET_DEVICE_ALT="jasmine_sprout,jasmine"
	export OF_TARGET_DEVICES="jasmine_sprout,jasmine"
	export OF_PATCH_AVB20=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
	export OF_USE_MAGISKBOOT="1"
	export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1510672800"; # Tue Nov 14 15:20:00 GMT 2017
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export OF_USE_SYSTEM_FINGERPRINT="1"
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-21.4.zip
	export OF_USE_GREEN_LED=1
	export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"

	# OTA
	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=0
	export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1

	# dm-verity/forced-encryption
	export OF_KEEP_DM_VERITY=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1

	# R11.1 Settings
	export FOX_VERSION="R11.1_3"
	export FOX_BUILD_TYPE="Test"
	export OF_MAINTAINER="Rahul
	# Screen Settings
	export OF_SCREEN_H=2160
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	# let's log what are the build VARs that we used
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
		export | grep "FOX" >> $FOX_BUILD_LOG_FILE
		export | grep "OF_" >> $FOX_BUILD_LOG_FILE
		export | grep "TW_" >> $FOX_BUILD_LOG_FILE
		export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
		export | grep "PLATFORM_" >> $FOX_BUILD_LOG_FILE
	fi
fi