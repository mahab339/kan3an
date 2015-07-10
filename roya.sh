#!/usr/bin/bash

make_activity_runnable()
{
	echo "Adding android:exported="true" to activity $1 in AndroidManifest.xml"
	#using $(MANIFEST_PATH), instead of the explisit path, raise permesion denide error
	MANIFEST_PATH=./app/src/main/AndroidManifest.xml
	# lines from <activity > starting from android:name until >
	# assuming the first line after <activity is android:name="", L contains all attributes of <activity >
	if [[ "$L" != *"android:exported=\"true\""* ]]; then
		#add exported="true" after android:name=""
			sed -i.copy 's/android:name="com.azhalha.androidapp.'$1'"/android:name="com.azhalha.androidapp.'$1'"\n\tandroid:exported="true"/' ./app/src/main/AndroidManifest.xml
		  echo "done modifying"
	fi
}

invert_manifest_modification()
{
	echo "invert modificating done to AndroidManifest.xml"
	mv $MANIFEST_PATH".copy" $MANIFEST_PATH
}

if [ -f ./gradlew ]; then
	make_activity_runnable $1
	./gradlew assembleDebug
	invert_manifest_modification
	adb install -r ./app/build/outputs/apk/app-debug.apk
	adb shell am start -n com.azhalha.androidapp/com.azhalha.androidapp.$1
else
	echo "Cannot find gradlew program"
fi
