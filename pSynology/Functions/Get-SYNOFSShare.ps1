function Get-SYNOFSShare {
	<#
	.SYNOPSIS
	List all shared folders.

	.DESCRIPTION
	Invokes the "list_share" method of SYNO.FileStation.List

	.PARAMETER offset
	Specify how many shared folders are skipped before beginning to return listed shared folders.

	.PARAMETER limit
	Number of shared folders requested.

	.PARAMETER sort_by
	Specify which file information to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER onlywritable
	“true”: List writable shared folders;
	“false”: List writable and read-only shared folders.

	.PARAMETER additional
	Additional requested file information

	.EXAMPLE
	Get-SYNOFSShare

	Lists all shared folders

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$limit,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("name", "user", "group", "mtime", "atime", "ctime", "crtime", "posix")]
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
		[boolean]$onlywritable,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("real_path", "owner", "time", "perm", "mount_point_type", "sync_share", "volume_status")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.List"
			method  = "list_share"
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
			$Response.shares
		}

	}#process

	END { }#end

}