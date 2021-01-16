# cyber-cheatsheets
Download a lot of cybersecurity cheatsheets

## Usage
Please install clamav before running this script. This script will download many files from various places, they need to be scanned.
Please do no worry if you forget the destination directory, a fail safe will a create a "tost" directory which will be use as a destination. Be carefull to the rm -rf though...
```
sudo freshclam
dl-cheatsheets.sh destination
```

## What is downloaded ?

### GIT repo
Some repositories which can be usefull in an informative way.

### The cheatlists

#### Misc
Downloading cheatsheets from here and there.

#### Sans
Downloading the cheatsheets from two official lists plus some missing ones.

#### Owasp
Downloading the prebuild site.

## TODO
Add an option to remove .list if wanted

Add an option to not run a scan if wanted

Rename ugly sans files
