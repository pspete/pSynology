# pSynology

## **pSynology: PowerShell module for the Synology API.**

Use PowerShell to issue Synology API commands.

----------

## Module Status

| Master Branch            | Code Coverage            | PowerShell Gallery       | License                   |
|--------------------------|--------------------------|--------------------------|---------------------------|
|[![appveyor][]][av-site]  | [![coveralls][]][cv-site]|[![psgallery][]][ps-site]|[![license][]][license-link]|

| Latest Build (All Branches) |
|-----------------------------|
|[![tests][]][tests-site]     |

[appveyor]:https://ci.appveyor.com/api/projects/status/pSynology/branch/master?svg=true
[av-site]:https://ci.appveyor.com/project/pspete/pSynology/branch/master
[coveralls]:https://coveralls.io/repos/github/pspete/pSynology/badge.svg
[cv-site]:https://coveralls.io/github/pspete/pSynology
[psgallery]:https://img.shields.io/powershellgallery/v/pSynology.svg
[ps-site]:https://www.powershellgallery.com/packages/pSynology
[license]:https://img.shields.io/github/license/pspete/pSynology.svg
[license-link]:https://github.com/pspete/pSynology/blob/master/LICENSE.md
[tests]:https://img.shields.io/appveyor/tests/pspete/pSynology.svg
[tests-site]:https://ci.appveyor.com/project/pspete/pSynology

- **pSynology is a work in progress - prior to a Version 1.0.0 release**:
  - Expect changes
  - Things may break
  - Issues / PRs are encouraged & appreciated

----------

## Project Objective

To eventually develop & publish PowerShell functions for all DSM 6.x API endpoints.

## List Of Commands

### SYNO.API

| Function                   | Description                                                                                 |
|----------------------------|---------------------------------------------------------------------------------------------|
| New-SYNOSession            | Authenticate to Synology Diskstation and start a new API session.                           |
| Close-SYNOSession          | Logoff from an API session                                                                  |
| Get-SYNOInfo               | Get DiskStation API information                                                             |

### SYNO.FileStation

| Function                   | Description                                                                                 |
|----------------------------|---------------------------------------------------------------------------------------------|
| Add-SYNOFSFavorite         | Add a folder to user's favourites                                                           |
| Add-SYNOFSFile             | Upload a file                                                                               |
| Clear-SYNOFSBackgroundTask | Delete all finished background tasks.                                                       |
| Clear-SYNOFSFavoriteStatus | Delete all favourites with broken status.                                                   |
| Clear-SYNOFSSharingLink    | Remove all expired and broken sharing links                                                 |
| Get-SYNOFSArchiveCompress  | Get the status of a compress task.                                                          |
| Get-SYNOFSArchiveContent   | List contents of an archive                                                                 |
| Get-SYNOFSArchiveExtract   | Get the extract task status                                                                 |
| Get-SYNOFSBackgroundTask   | List all background tasks including copy                                                    |
| Get-SYNOFSCopy             | Get the status of a copy operation                                                          |
| Get-SYNOFSDeleteItem       | Get the status pf a Delete task                                                             |
| Get-SYNOFSDirSize          | Get the status of the size calculating task                                                 |
| Get-SYNOFSFavorite         | List user's favourites                                                                      |
| Get-SYNOFSFile             | Enumerate files in a given folder                                                           |
| Get-SYNOFSFileInfo         | Get information of file(s)                                                                  |
| Get-SYNOFSInfo             | Get File Station information                                                                |
| Get-SYNOFSMD5              | Get the status of the calculating MD5 task.                                                 |
| Get-SYNOFSSearch           | List matched files in a search temporary database.                                          |
| Get-SYNOFSShare            | List all shared folders.                                                                    |
| Get-SYNOFSSharingLink      | List user’s file sharing links.                                                             |
| Get-SYNOFSSharingLinkInfo  | Get information of a sharing link by the sharing link ID                                    |
| Get-SYNOFSThumbnail        | Get a thumbnail of a file.                                                                  |
| Get-SYNOFSVirtualFolder    | List all mount point folders of a given type of virtual file system                         |
| New-SYNOFSFolder           | Create folders                                                                              |
| New-SYNOFSSharingLink      | Generate one or more sharing link(s) by file/folder path(s)                                 |
| Remove-SYNOFSFavorite      | Delete a favourite from user's favourites.                                                  |
| Remove-SYNOFSItem          | Delete files/folders.                                                                       |
| Remove-SYNOFSSearch        | Delete search temporary database(s)                                                         |
| Remove-SYNOFSSharingLink   | Delete one or more sharing links.                                                           |
| Rename-SYNOFSItem          | Rename a file/folder.                                                                       |
| Save-SYNOFSFile            | Download files/folders.                                                                     |
| Set-SYNOFSFavorite         | Edit a favourite name.                                                                      |
| Set-SYNOFSSharingLink      | Edit sharing link(s)                                                                        |
| Start-SYNOFSArchiveCompress| Start to compress file(s)/folder(s).                                                        |
| Start-SYNOFSArchiveExtract | Start to extract an archive.                                                                |
| Start-SYNOFSCopy           | Start to copy files                                                                         |
| Start-SYNOFSDeleteItem     | Delete file(s)/folder(s)                                                                    |
| Start-SYNOFSDirSize        | Start to calculate size for one or more file/folder paths.                                  |
| Start-SYNOFSMD5            | Start to get MD5 of a file                                                                  |
| Start-SYNOFSSearch         | Start to search files according to given criteria.…                                         |
| Stop-SYNOFSArchiveCompress | Stop a compress task                                                                        |
| Stop-SYNOFSArchiveExtract  | Stop an extract task                                                                        |
| Stop-SYNOFSCopy            | Stop a copy task.                                                                           |
| Stop-SYNOFSDeleteItem      | Stop a delete task                                                                          |
| Stop-SYNOFSDirSize         | Stop to calculate size                                                                      |
| Stop-SYNOFSMD5             | Stop calculating the MD5 of a file                                                          |
| Stop-SYNOFSSearch          | Stop the searching task(s).…                                                                |
| Test-SYNOFSPermission      | Check if a logged-in user has write permission on a given folder                            |
| Update-SYNOFSFavorite      | Replace multiple favourites of folders in the user's favourites.                            |

## TODO

| API Endpoint           | Status             |
|------------------------|--------------------|
| SYNO.API               | Partially Complete |
| SYNO.FileStation       | Partially Complete |
| SYNO.AudioPlayer       | ToDo               |
| SYNO.Backup            | ToDo               |
| SYNO.Btrfs             | ToDo               |
| SYNO.CCC               | ToDo               |
| SYNO.Core              | ToDo               |
| SYNO.DR                | ToDo               |
| SYNO.DSM               | ToDo               |
| SYNO.DTV               | ToDo               |
| SYNO.DisasterRecovery  | ToDo               |
| SYNO.Docker            | ToDo               |
| SYNO.Entry             | ToDo               |
| SYNO.Finder            | ToDo               |
| SYNO.FolderSharing     | ToDo               |
| SYNO.License           | ToDo               |
| SYNO.MediaServer       | ToDo               |
| SYNO.OAUTH             | ToDo               |
| SYNO.Package           | ToDo               |
| SYNO.PersonMailAccount | ToDo               |
| SYNO.Personal          | ToDo               |
| SYNO.Photo             | ToDo               |
| SYNO.PhotoTeam         | ToDo               |
| SYNO.ResourceMonitor   | ToDo               |
| SYNO.S2S               | ToDo               |
| SYNO.SAS               | ToDo               |
| SYNO.SecurityAdvisor   | ToDo               |
| SYNO.Snap              | ToDo               |
| SYNO.Storage           | ToDo               |
| SYNO.SynologyDrive     | ToDo               |
| SYNO.Utils             | ToDo               |
| SYNO.VMMDR             | ToDo               |
| SYNO.VPNServer         | ToDo               |
| SYNO.VideoController   | ToDo               |
| SYNO.VideoPlayer       | ToDo               |
| SYNO.VideoStataion     | ToDo               |
| SYNO.VideoStation      | ToDo               |
| SYNO.VideoStation2     | ToDo               |
| SYNO.Virtualization    | ToDo               |
| SYNO.WebStation        | ToDo               |

## Installation

### Prerequisites

- Requires Powershell (v5 minimum) Or PSCore (v6)
- A Synology NAS / DSM
- An Account to Access Synology DSM

### Install Options

This repository contains a folder named ```pSynology```.

The folder needs to be copied to one of your PowerShell Module Directories.

#### Manual Install

Find your PowerShell Module Paths with the following command:

```powershell

$env:PSModulePath.split(';')

```

[Download the ```dev``` branch](https://github.com/pspete/pSynology/archive/dev.zip)

Extract the archive

Copy the ```pSynology``` folder to your "Powershell Modules" directory of choice.