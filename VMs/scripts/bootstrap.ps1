# Install packages
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install git cmake mingw 7zip.commandline ag diffmerge notepad2 ruby wincommandpaste git-credential-winstore

# Setup PATH
$env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Init git
git config --global user.email "michael.smith@puppetlabs.com"
git config --global user.name "Michael Smith"
git config --global push.default simple

# Chocolatey install of poshgit hasn't been working reliably, install from source instead.
#choco install poshgit
git clone https://github.com/dahlbyk/posh-git
.\posh-git\install.ps1
. $PROFILE
rm -r posh-git

# Add bundle
gem install bundle

# Optional packages
choco install make python2 VisualStudioExpress2013WindowsDesktop ActivePerl ruby2.devkit

# Setup ruby devkit
$RubyInstall = Split-Path (Split-Path (Get-Command ruby).Path)
C:\DevKit2\dk.rb init
Add-Content config.yml "- $RubyInstall"
C:\DevKit2\dk.rb install
rm config.yml

# Clean up the environment
$vcpath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin"
[System.Collections.ArrayList]$path =
  [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) -split ";"
if ($path -notcontains $vcpath) {
    [void]$path.Add($vcpath)
}
$gitpath = "C:\Program Files (x86)\Git\bin"
if ($path -contains $gitpath) {
    [void]$path.Remove($gitpath)
}
[Environment]::SetEnvironmentVariable("Path", $path -join ";", [System.EnvironmentVariableTarget]::Machine)

# Figure out how to set the keyboard to Dvorak
Set-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_USERS\.DEFAULT\Keyboard Layout\Preload" -Name 1 -Value 00010409
Set-ItemProperty -Path "HKCU:\Keyboard Layout\Preload" -Name 1 -Value 00010409

