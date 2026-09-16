@echo off
echo Setting up Java environment variables...

:: Set JAVA_HOME
setx JAVA_HOME "C:\Program Files\Eclipse Adoptium\jdk-17.0.9.9-hotspot" /M

:: Add Java to PATH
setx PATH "%PATH%;%%JAVA_HOME%%\bin" /M

echo Java environment variables have been set.
echo Please close and reopen your terminal for the changes to take effect.
pause 