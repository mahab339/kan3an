#!/usr/bin/bash

PACKAGE_NAME="com.azhalha.androidapp"

make_activity_runnable()
{
	echo "Adding android:exported=\"true\" to activity $1 in AndroidManifest.xml"
	#using $(MANIFEST_PATH), instead of the explisit path, raise permesion denide error
	MANIFEST_PATH=./app/src/main/AndroidManifest.xml
	# lines from <activity > starting from android:name until >
	# assuming the first line after <activity is android:name="", ACTIVITY_ATTRS contains all attributes of <activity >
	ACTIVITY_ATTRS=$(sed -n '/android:name="'$PACKAGE_NAME'.'$1'"/,/>/p' ./app/src/main/AndroidManifest.xml)
	if [[ "$ACTIVITY_ATTRS" != *"android:exported=\"true\""* ]]; then
		#add exported="true" after android:name=""
		sed -i.copy 's/android:name="'$PACKAGE_NAME'.'$1'"/android:name="'$PACKAGE_NAME'.'$1'"\n\tandroid:exported="true"/' ./app/src/main/AndroidManifest.xml
		echo "Done modifying..."
	else
		echo "Nothing to modify..."
	fi
}

# replace the AndroidManifest.xml.copy, which is the manifest file before
# applying the modifications, with the modified manifest.
# this method is usally called afer building the application
invert_manifest_modification()
{
	if [ -a $MANIFEST_PATH".copy" ]; then
		echo "Inverting modificating done to AndroidManifest.xml"
		mv $MANIFEST_PATH".copy" $MANIFEST_PATH
	fi
}

if [ -f ./gradlew ]; then
	make_activity_runnable $1
	./gradlew assembleDebug
	invert_manifest_modification
	adb install -r ./app/build/outputs/apk/app-debug.apk
	adb shell am start -n $PACKAGE_NAME/$PACKAGE_NAME.$1
else
	echo "Cannot find gradlew program"
fi
