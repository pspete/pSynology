function Get-SYNOFSSearch {
	<#
	.SYNOPSIS
	List matched files in a search temporary database.

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.Search

	.PARAMETER taskid
	A unique ID for the search task

	.PARAMETER offset
	Specify how many matched files are skipped before beginning to return listed matched files.

	.PARAMETER limit
	Number of matched files requested.

	.PARAMETER sort_by
	Specify which file information to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER pattern
	Given glob pattern(s) to find files whose names and extensions match a case-insensitive glob pattern.

	.PARAMETER filetype
	“file”: enumerate regular files;
	“dir”: enumerate folders;
	“all” enumerate regular files and folders.

	.PARAMETER additional
	Additional requested file information

	.EXAMPLE
	Get-SYNOFSSearch -taskid 5CDC455CE78D0CF0

	List matched files in search task with id 5CDC455CE78D0CF0

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$taskid,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$offset,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("name", "size", "user", "group", "mtime", "atime", "ctime", "crtime", "posix", "type")]
		[string]$sort_by,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("asc", "desc")]
		[string]$sort_direction,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$pattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("file", "dir", "all")]
		[string]$filetype,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Search"
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
			$Response
		}

	}#process

	END { }#end

}