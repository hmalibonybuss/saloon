# Set JAVA_HOME
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.9.9-hotspot"

# Add Java to PATH
$env:Path = "$env:JAVA_HOME\bin;$env:Path"

# Verify Java installation
Write-Host "Verifying Java installation..."
java -version

Write-Host "Environment variables have been set for this session."
Write-Host "JAVA_HOME is now: $env:JAVA_HOME" 