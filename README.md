# roya
A simple bash script to be used while developing Android apps to launch the application from the AndroidStudio project to a testing device.

###Requrements
1. gradlw program<br>
Typically found on the Android Studio **project** directory. It may need to be run one time at first to set things up.

2. adb program<br>
if it is found in the SDK folder, add it to the PATH variable. Otherwise install it to your system.

3. A physical device connected to the computer and set up for debugging.<br>

###Usage
Running the script for the first time, it will ask for the development package name:<br>
~$ roya.sh
~$ No package has been specified yet<br>
~$ Enter the package name i.e com.example.androidapp<br>
~$ 

* To launch ActivityName to the physical device: `roya.sh ActivityName`
* To change the package name used in the script to com.example.androidapp:<br> 
`roya.sh --set PACKAGE=com.example.androidapp` or `roya.sh -s PACKAGE=com.example.androidapp`

###TODO
For the sake of learning the powerful tool; shell scripting. I intend to add the following features to the script:
* Support emulator, add option that launch the emulator instead of a physical device.
* An option for the user to specify the launcher activity.
* ~~Set the default launcher activity from the terminal.~~ <sub> finished on: Wed Jul  8 01:45:45 AST 2015 </sub>
* ~~Set the package name from terminal globally (one time).~~ <sub> added on Wed Jul  8 01:46:50 AST 2015 </sub>,  <sub> Done on Fri Jul 17 16:38:52 AST 2015</sub>
* Adding "launch without rebuilding" option.
* Support options `--stacktrace` and `--info` to be used with gradlew.

Currently reading this book about bash and bash scripting: [Bash Guide for Beginners](http://tille.garrels.be/training/bash/). Which I found very helpful for understanding the basic concepts behind bash.
