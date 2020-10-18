#!/bin/bash
# Autostart run script for Kiosk mode, based on @AYapejian https://github.com/MichaIng/DietPi/issues/1737#issue-318697621
# - Please see /root/.chromium-browser.init (and /etc/chromium.d/custom_flags) for additional egl/gl init options

# Command line switches https://peter.sh/experiments/chromium-command-line-switches/
# --test-type gets rid of some of the chromium warnings that you may or may not care about in kiosk on a LAN
# --pull-to-refresh=1
# --ash-host-window-bounds="400,300"

RES_X=1280
RES_Y=720
URL=http://localhost:1880
SCALEX=1.60
CHROMIUM_OPTS="--kiosk --window-size=$RES_X,$RES_Y --start-fullscreen --start-maximized --check-for-update-interval=31536000 --window-position=0,0 --force-device-scale-factor=$SCALEX --enable-use-zoom-for-dsf --bwsi --disable-breakpad --enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter --homepage $URL"

# Find absolute filepath location of Chromium binary.
FP_CHROMIUM=$(command -v chromium)
if [[ ! $FP_CHROMIUM ]]; then

	# - Assume RPi
	FP_CHROMIUM="$(command -v chromium-browser)"

fi

xinit $FP_CHROMIUM $CHROMIUM_OPTS -- -nocursor
