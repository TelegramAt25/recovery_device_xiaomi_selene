#!/usr/bin/env bash
#
#  This file is part of the OrangeFox Recovery Project
#   Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#  OrangeFox is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  any later version.
#
#  OrangeFox is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#   This software is released under GPL version 3 or any later version.
#  See <http://www.gnu.org/licenses/>.
#
#   Please maintain this if you use this script or any part of it
#

FDEVICE="selene"
#set -o xtrace

fox_get_target_device() {
  local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
  if [ -n "$chkdev" ]; then
    FOX_BUILD_DEVICE="$FDEVICE"
  else
    chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
    [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
  fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
  fox_get_target_device
fi

# Dirty Fix: Only declare orangefox vars when needed
if [ -f "$(gettop)/bootable/recovery/orangefox.cpp" ]; then
  echo -e "\x1b[96m[INFO]: Setting up OrangeFox build vars for selene...\x1b[m"
  if [ "$1" = "$FDEVICE" ] || [  "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    # Version / Maintainer infos
    export OF_MAINTAINER="TillYourTearGoes"
    export OF_MAINTAINER_AVATAR="$(gettop)/device/xiaomi/selene/maintainer_avatar.png"
    export FOX_VERSION=R11.1_4
    export FOX_VANILLA_BUILD=1
    #export FOX_VARIANT=A11
    export FOX_BUILD_TYPE="Unofficial"

    # Device info
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export TARGET_DEVICE_ALT="selenes, eos"

    # OTA / DM-Verity / Encryption
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1

    export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
    #export OF_SKIP_FBE_DECRYPTION_SDKVERSION=34
    export OF_SKIP_DECRYPTED_ADOPTED_STORAGE=1
    export OF_DEFAULT_KEYMASTER_VERSION=4.0
    export OF_FORCE_USE_RECOVERY_FSTAB=1

    # Display / Leds
    export OF_SCREEN_H="2400"
    export OF_STATUS_H="100"
    export OF_STATUS_INDENT_LEFT=64
    export OF_STATUS_INDENT_RIGHT=64
    export OF_HIDE_NOTCH=1
    export OF_CLOCK_POS=1 # left and right clock positions available
    export OF_USE_GREEN_LED=0
    export OF_FL_PATH1="/system/flashlight"

    # Other OrangeFox configs
    export OF_ENABLE_LPTOOLS=1
    export OF_ALLOW_DISABLE_NAVBAR=0
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"; # Sun 21 Mar 04:26:40 GMT 2021
    export FOX_REPLACE_BOOTIMAGE_DATE=1
    export FOX_DELETE_AROMAFM=1
    export FOX_USE_NANO_EDITOR=0
    export FOX_EXCLUDE_NANO_EDITOR=1
    export FOX_REMOVE_ZIP_BINARY=1
    export FOX_REMOVE_AAPT=1
    export FOX_REMOVE_BASH=1

    export FOX_DELETE_INITD_ADDON=1
    export FOX_DELETE_MAGISK_ADDON=1
    export FOX_NO_SAMSUNG_SPECIAL=1
    export OF_NO_ADDITIONAL_MIUI_PROPS_CHECK=1

    export OF_DONT_KEEP_LOG_HISTORY=1
    export FOX_DISABLE_UPDATEZIP=1

    cp "${OF_MAINTAINER_AVATAR}" "$(gettop)/bootable/recovery/gui/theme/portrait_hdpi/images/Default/About/maintainer.png"
  fi
fi
