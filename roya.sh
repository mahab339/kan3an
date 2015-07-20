#!/usr/bin/bash

PACKAGE=com.azhalha.androidapp

make_activity_runnable()
{
	echo "Adding android:exported=\"true\" to activity $1 in AndroidManifest.xml"
	#using $(MANIFEST_PATH), instead of the explisit path, raise permesion denide error
	MANIFEST_PATH=./app/src/main/AndroidManifest.xml
	# lines from <activity > starting from android:name until >
	# assuming the first line after <activity is android:name="", ACTIVITY_ATTRS contains all attributes of <activity >
	ACTIVITY_ATTRS=$(sed -n '/android:name="'$PACKAGE'.'$1'"/,/>/p' ./app/src/main/AndroidManifest.xml)
	if [[ "$ACTIVITY_ATTRS" != *"android:exported=\"true\""* ]]; then
		#add exported="true" after android:name=""
		sed -i.copy 's/android:name="'$PACKAGE'.'$1'"/android:name="'$PACKAGE'.'$1'"\n\tandroid:exported="true"/' ./app/src/main/AndroidManifest.xml
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

# change the variable value in the script, alter the script using sed, and exit
# right now, variables that can be changed are PACKAGE
set_var()
{
	VAR=${1/=*/}
	VAL=${1/*=/}
	sed -i 's/'^$VAR'=.*/'$1'/' `basename "$0"`
	echo $VAR "has been set to" $VAL "sccessfully..."
	exit
}


run_without_rebuild()
{
	adb install -r ./app/build/outputs/apk/app-debug.apk
	adb shell am start -n $PACKAGE/$PACKAGE.$1
	exit
}

#seting options
#options till now are:
# -s|--set to set variable to values
	while [[ $# > 0 && $1 == -* ]]
	do
	key="$1"

	case $key in
	    -s|--set) #set a variable to a value
	    set_var $2
	    shift # past argument
	    ;;

			-d|--no-rebuild) #the opposite of (b)uild is (d)uild
			run_without_rebuild $2
			shift
			;;
	    *)
	            # unknown option
	    ;;
	esac
	shift # past argument or value
	done


#prompts the user to enter the main package name,
#and use set_var function to set PACKAGE to the user input.
read_package_name()
{
	printf "No package has been specified yet\nEnter the package name i.e com.example.androidapp\n"
	read package
	P="PACKAGE="$package
	set_var $P
}

#make sure gradlew exists
if [ ! -f ./gradlew ]; then
	echo "Cannot find gradlew program"
	exit
fi

#If PACKAGE=="unset", read package name
if [ $PACKAGE == "unset" ]; then
	read_package_name
fi

make_activity_runnable $1
./gradlew assembleDebug
invert_manifest_modification
adb install -r ./app/build/outputs/apk/app-debug.apk
adb shell am start -n $PACKAGE/$PACKAGE.$1
