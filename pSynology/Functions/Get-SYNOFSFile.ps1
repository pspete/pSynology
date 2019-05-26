function Get-SYNOFSFile {
	<#
	.SYNOPSIS
	Enumerate files in a given folder

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.List

	.PARAMETER folder_path
	A listed folder path started with a shared folder.

	.PARAMETER offset
	Specify how many files are skipped before beginning to return listed files.

	.PARAMETER limit
	Number of files requested.

	.PARAMETER sort_by
	Specify which file information to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER pattern
	Given glob pattern(s) to find files whose names and extensions match a case-insensitive glob pattern.

	.PARAMETER filetype
	“file”: only enumerate regular files
	“dir”: only enumerate folders
	“all” enumerate regular files and folders

	.PARAMETER goto_path
	Folder path started with a shared folder.
	Return all files and sub-folders within folder_path path until goto_path path recursively.

	.PARAMETER additional
	Additional requested file information.

	.EXAMPLE
	Get-SYNOFSFile -folder_path /home/docs

	Lists all files in the /home/docs directory

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$folder_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$limit,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[ValidateSet("name", "size", "user", "group", "mtime", "atime", "ctime", "crtime", "posix", "type")]
		[string]$sort_by,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("asc", "desc")]
		[string]$sort_direction,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$pattern,

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
		[string]$goto_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type" , "mount_point_type")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.List"
			method  = "list"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response.files
		}

	}#process

	END { }#end

}