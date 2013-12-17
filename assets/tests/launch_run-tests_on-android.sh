#!/bin/sh

set -e
set -x

echoheader() {
    echo ""
    echo ========================================================================
}

echoheader
echo "looking for adb in SDK_BASE: $SDK_BASE"

if [ -z $SDK_BASE ]; then
    . ~/.android/bashrc
else
    export PATH="$PATH:$SDK_BASE/tools"
fi


echoheader
echo "Checking which user 'adb shell' defaults to:"
adb shell whoami
adb shell 'echo $USER'
adb shell 'echo $HOME'


echoheader
echo "What files got installed?"
adb shell 'ls -l /data/data/info.guardianproject.gpg'
adb shell 'ls -l /data/data/info.guardianproject.gpg/lib'
adb shell 'ls -l /data/data/info.guardianproject.gpg/app_opt'
adb shell 'ls -l /data/data/info.guardianproject.gpg/app_opt/bin'
adb shell 'ls -l /data/data/info.guardianproject.gpg/app_opt/lib'


echoheader
echo "Printing the environment variables: "
adb shell set


echoheader
echo "Running run-tests.sh on Android via ADB:"
adb shell /data/data/info.guardianproject.gpg/app_opt/tests/run-tests.sh
