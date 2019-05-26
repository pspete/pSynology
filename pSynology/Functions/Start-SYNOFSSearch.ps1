function Start-SYNOFSSearch {
	<#
	.SYNOPSIS
	Start to search files according to given criteria.
	If more than one criterion is given in different parameters, searched files match all these criteria.

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.Search

	.PARAMETER folder_path
	A searched folder path starting with a shared folder.

	.PARAMETER recursive
	If searching files within a folder and subfolders recursively or not.

	.PARAMETER pattern
	Search for files whose names and extensions match a case-insensitive glob pattern.

	.PARAMETER extension
	Search for files whose extensions match a file typepattern in a case-insensitive globpattern.
	If specified, folders are not matched.

	.PARAMETER filetype
	“file”: enumerate regular files;
	“dir”: enumerate folders;
	“all” enumerate regular files and folders.

	.PARAMETER size_from
	Search for files whose sizes are greater than the given byte size.

	.PARAMETER size_to
	Search for files whose sizes are less than the given byte size.

	.PARAMETER mtime_from
	Search for files whose last modified time after the given datetime

	.PARAMETER mtime_to
	Search for files whose last modified time before the given datetime

	.PARAMETER crtime_from
	Search for files whose create time after the given datetime

	.PARAMETER crtime_to
	Search for files whose create time before the given datetime

	.PARAMETER atime_from
	Search for files whose last access time after the given datetime

	.PARAMETER atime_to
	Search for files whose last access time before the given datetime

	.PARAMETER owner
	Search for files whose user name matches this criteria.

	.PARAMETER group
	Search for files whose group name matches this criteria

	.EXAMPLE
	Start-SYNOFSSearch -folder_path /home/docs/ -extension doc

	Starts search task for "doc" files in the /home/docs/ folder

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$folder_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$recursive,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$pattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$extension,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("file", "dir", "all")]
		[string]$filetype,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$size_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$size_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$mtime_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$mtime_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$crtime_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$crtime_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$atime_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$atime_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$owner,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$group
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Search"
			method  = "start"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

		$TimeParameters = @("mtime_from", "mtime_to", "crtime_from", "crtime_to", "atime_from", "atime_to")

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		foreach ($TimeParameter in $TimeParameters) {

			if ($PSBoundParameters.ContainsKey("$TimeParameter")) {

				#convert to unix time
				$Parameters["$TimeParameter"] = Get-Date $($PSBoundParameters["$TimeParameter"]) -UFormat %s

			}

		}

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response.taskid
			}

		}

	}#process

	END { }#end

}