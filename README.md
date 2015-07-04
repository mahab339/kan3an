# roya
A simple bash script to be used while developing Android apps to launch the application from the AndroidStudio project to a testing device.
###why
One thing I hated about Android Studio is that it doesn't provide any feedback while the Gradle is building and running project, whether about errors or the percentage of completion. To overcome this issue, I found using command line is very helpful. There are three commands to build, install, and launch a project typically:

1- `./gradlew assembleDebug`

2- ` adb install -r ./app/build/outputs/apk/app-debug.apk`

3- `adb shell am start -n com.azhalha.androidapp/com.azhalha.androidapp.Signup`

where `com.azhalha.androidapp/com.azhalha.androidapp.Signup` is the launcher activity.<br>
roya.sh is simply running these commands in sequence, instead of typing them every time.

###Requrements
1. gradlw program<br>
Typically found on the Android Studio **project** directory. You may need to run it one time at first to set things up.

2. adb program<br>
if it is found in the SDK folder, add it to the PATH variable. Otherwise install it to your system.

3. A physical device connected to the computer and set up for debugging.<br>
Only one device (if you are super rich and have more than one phone, connect only one at a time)

###TODO
For the sake of learning the very powerful tool: shell scripting. I intend to add the following features to the script:
* Support emulator, add option that launch the emulator instead of a physical device.
* An option for the user to specify the launcher activity.
* Set the default launcher activity from the terminal.
* Adding "launch without rebuilding" option.
* Support options `--stacktrace` and `--info` to be used with gradlew.

I am currently reading this book about bash and bash scripting: [Bash Guide for Beginners](http://tille.garrels.be/training/bash/). Which is very helpful for understanding the basic concepts behind bash.
