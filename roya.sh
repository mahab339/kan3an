#!/usr/bin/bash
if [ -f gradlew ]; then
	./gradlew assembleDebug
	adb install -r ./app/build/outputs/apk/app-debug.apk
	adb shell am start -n com.azhalha.androidapp/com.azhalha.androidapp.Signup
else
	echo "Cannot find gradlew program"
fi
